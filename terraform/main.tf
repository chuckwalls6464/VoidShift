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
  vmid        = "320"
  os_type     = "cloud-init"
  boot        = "order=virtio0"
  agent       = 1
  # Cloud-Init configuration
  ciuser     = "dracula"
  cipassword = var.cipassword
  sshkeys    = var.sshkey_location
  ipconfig0  = "ip=192.168.0.76/24,gw=192.168.0.1"
  nameserver = var.dns_server

  cpu {
    cores   = 2
    sockets = 1
  }

  memory = 2048

  disks {
    virtio {
      virtio0 {
        disk {
          size    = "20G"
          storage = "tank"
        }
      }
    }
    ide {
      ide1 {
        cloudinit {
          storage = "tank"
        }
      }
    }
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
  }

  serial {
    id = 0
  }
}
