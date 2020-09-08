tags       = {}
convention = "cafrandom"
resource_groups = {
  aks1 = {
    name       = "aks-1"
    region   = "region1"
    useprefix  = true
    max_length = 40
  }
}

clusters = {
  seacluster = {
    name                = "akscluster-001"
    resource_group_key = "aks1"
    os_type             = "Linux"

    identity = {
      type = "SystemAssigned"
    }

    kubernetes_version = "1.17.7"
    vnet_key           = "spoke_aks_sg"

    network_policy = {
      network_plugin    = "azure"
      load_balancer_sku = "Standard"
    }
    
    private_cluster_enabled = true
    enable_rbac = true
    outbound_type = "userDefinedRouting"

    load_balancer_profile = {
      # Only one option can be set
      managed_outbound_ip_count = 1
      # outbound_ip_prefix_ids = []
      # outbound_ip_address_ids = []
    }

    default_node_pool = {
      name                  = "sharedsvc"
      vm_size               = "Standard_F4s_v2"
      subnet_key           = "aks_nodepool_system"
      enabled_auto_scaling  = false
      enable_node_public_ip = false
      max_pods              = 30
      node_count            = 2
      os_disk_size_gb       = 512
      orchestrator_version  = "1.17.7"
      tags = {
        "project" = "system services"
      }
    }
  }
}

jumpboxes = {
  ubuntu = {
    name = "ubuntujumpbox"
    resource_group_name = "jumpbox"
    location = "southeastasia"
    os = "Linux"
    vnet_key           = "hub_sg"
    subnet_key         = "jumpbox"
    storage_image_reference = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }
    vm_size = "Standard_DS1_v2"
    os_profile = {
        admin_username = "testadmin"
        admin_password = "Ab123456789!"
    }
    storage_os_disk = {
      name              = "ubuntuosdisk1"
      caching           = "ReadWrite"
      create_option     = "FromImage"
      managed_disk_type = "Standard_LRS"
      disk_size_gb      = "128"
    }
  }
}