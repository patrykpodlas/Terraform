# Create the resource group for permanent resources
resource "azurerm_resource_group" "image_resource_group" {
  name     = var.ImageResourceGroup
  location = var.Location
}

resource "azurerm_resource_group" "vnet_resource_group" {
  name     = var.vNetResourceGroup
  location = var.Location
}

# Create the resource group for staging resources
resource "azurerm_resource_group" "staging_resource_group" {
  name     = var.StagingImageResourceGroup
  location = var.Location
}

# Create the Azure Compute Gallery
resource "azurerm_shared_image_gallery" "compute_gallery" {
  name                = var.GalleryName
  resource_group_name = azurerm_resource_group.image_resource_group.name
  location            = azurerm_resource_group.image_resource_group.location
}

# Create the Azure Compute Gallery image definition
resource "azurerm_shared_image" "compute_gallery_image" {
  name                = var.ImageDefinitionName
  gallery_name        = azurerm_shared_image_gallery.compute_gallery.name
  resource_group_name = azurerm_resource_group.image_resource_group.name
  location            = azurerm_resource_group.image_resource_group.location
  specialized         = "false"
  os_type             = "Windows"
  hyper_v_generation  = var.VMGeneration
  identifier {
    publisher = var.CompanyName
    offer     = "windows_11_gen2"
    sku       = "generic"
  }
}

# Create the virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vNETName
  resource_group_name = azurerm_resource_group.vnet_resource_group.name
  location            = var.Location
  address_space       = ["10.0.0.0/16"]
}

# Create the subnet within the virtual network
resource "azurerm_subnet" "subnet" {
  name                 = var.SubnetName
  resource_group_name  = azurerm_resource_group.vnet_resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create the network security group with a security rule
resource "azurerm_network_security_group" "nsg" {
  name                = var.NSGName
  resource_group_name = azurerm_resource_group.vnet_resource_group.name
  location            = azurerm_resource_group.vnet_resource_group.location
  security_rule {
    name                       = "AzureImageBuilderAccess"
    description                = "Allow Image Builder Private Link Access to Proxy VM"
    priority                   = "400"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "60000-60001"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "VirtualNetwork"
  }
}

resource "azurerm_subnet_network_security_group_association" "associate" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create the user managed identity
resource "azurerm_user_assigned_identity" "identity" {
  name                = var.IdentityName
  resource_group_name = azurerm_resource_group.image_resource_group.name
  location            = var.Location
}

# Create the custom role definitions
resource "azurerm_role_definition" "image_creation_role" {
  name  = var.ImageRoleDefinitionName
  scope = azurerm_resource_group.image_resource_group.id
  permissions {
    actions = [
      "Microsoft.Compute/galleries/read",
      "Microsoft.Compute/galleries/images/read",
      "Microsoft.Compute/galleries/images/versions/read",
      "Microsoft.Compute/galleries/images/versions/write",
      "Microsoft.Compute/images/write",
      "Microsoft.Compute/images/read",
      "Microsoft.Compute/images/delete"
    ]
    not_actions      = []
    data_actions     = []
    not_data_actions = []
  }
  assignable_scopes = [azurerm_resource_group.image_resource_group.id]
}

resource "azurerm_role_definition" "network_join_role" {
  name  = var.NetworkRoleDefinitionName
  scope = azurerm_resource_group.vnet_resource_group.id
  permissions {
    actions = [
      "Microsoft.Network/virtualNetworks/read",
      "Microsoft.Network/virtualNetworks/subnets/join/action"
    ]
    not_actions      = []
    data_actions     = []
    not_data_actions = []
  }
  assignable_scopes = [azurerm_resource_group.vnet_resource_group.id]
}

resource "azurerm_role_assignment" "image_creation_role" {
  scope              = azurerm_resource_group.image_resource_group.id
  role_definition_id = azurerm_role_definition.image_creation_role.role_definition_resource_id
  principal_id       = azurerm_user_assigned_identity.identity.principal_id
}

resource "azurerm_role_assignment" "network_join_role" {
  scope              = azurerm_resource_group.vnet_resource_group.id
  role_definition_id = azurerm_role_definition.network_join_role.role_definition_resource_id
  principal_id       = azurerm_user_assigned_identity.identity.principal_id
}

resource "azurerm_role_assignment" "contributor_umi" {
  scope                = azurerm_resource_group.staging_resource_group.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.identity.principal_id
}

resource "azurerm_role_assignment" "contributor_avib" {
  scope                = azurerm_resource_group.staging_resource_group.id
  role_definition_name = "Contributor"
  principal_id         = data.azuread_service_principal.avib.id
}
