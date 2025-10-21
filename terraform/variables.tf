variable "cipassword" {
  description = "Cloud-init password for the VM"
  type        = string

}

variable "sshkey_location" {
  description = "Path to the SSH public key file"
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIESBEyiXj4M2tCY97+fn0u73hBAuDwCA1V24lWuGWARQ ansible"
}

variable "dns_server" {
  description = "DNS server for the VM"
  type        = string
}
