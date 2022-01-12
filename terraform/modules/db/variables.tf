variable db_instance_name {
  description = "Name and tag for app instance"
  default     = "reddit-db"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
variable db_disk_type {
  description = "Disk type for app instance"
  default     = "network-ssd"
}
variable subnet_id {
  description = "Subnets for modules"
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
