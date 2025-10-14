terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.2-rc04"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://192.168.0.110:8006/api2/json"
  pm_tls_insecure = true
}


resource "proxmox_vm_qemu" "clone-test" {
  name        = "tf-clone-test"
  target_node = "pmox01"
  clone       = "ubuntu-22.04-cloud"
  full_clone  = false

  os_type = "cloud-init"

  cpu {
    cores   = 2
    sockets = 1
  }

  memory = 2048


  disk {
    slot    = "scsi0"
    size    = "20G"
    storage = "tank"
    type    = "disk"
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
  }

  ipconfig0 = "ip=192.168.0.234/24,gw=192.168.0.1"
}
