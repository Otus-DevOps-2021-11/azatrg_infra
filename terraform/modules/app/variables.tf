variable app_instance_name {
  description = "Name and tag for app instance"
  default     = "reddit-app"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable app_disk_type {
  description = "Disk type for app instance"
  default     = "network-hdd"
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
    default = "~/.ssh/appuser"
}
variable database_url {
  description = "ip address of mongo db instance"
}
