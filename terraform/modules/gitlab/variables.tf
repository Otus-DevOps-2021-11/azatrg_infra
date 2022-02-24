variable gitlab_instance_name {
  description = "Name and tag for gitlab instance"
  default     = "gitlab"
}
variable gitlab_disk_image {
  description = "Disk image for Gitlab CI"
  default     = "ubuntu-1804-lts"
}
variable gitlab_disk_type {
  description = "Disk type for app instance"
  default     = "network-ssd"
}
variable gitlab_disk_size {
  description = "Disk size for gitlab"
  default     = 50
}
variable subnet_id {
  description = "Subnets for modules"
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable private_key_path {
  description = "Path to the provate key used for ssh provision"
  default     = "~/.ssh/appuser"
}
