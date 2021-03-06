variable cloud_id {
  description = "Cloud"
}
variable folder_id {
  description = "Folder"
}
variable zone {
  description = "Zone"
  default     = "ru-central1-a"
}
variable network_name {
  description = "network,subnet name"
  default     = "reddit-net-stage"
}
variable app_instance_name {
  description = "Instance name"
  default     = "reddit-app"
}
variable db_instance_name {
  description = "Instance name"
  default     = "reddit-db"
}
variable gitlab_instance_name {
  description = "Instance name"
  default     = "gitlab"
}
variable instance_count {
  description = "Number of instances"
  default     = 1
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable private_key_path {
  description = "Path to the public key used for ssh access"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  # default     = "reddit-app-base"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  # default     = "reddit-db-base"
}
variable gitlab_disk_image {
  description = "Disk image for reddit db"
}
variable service_account_key_file {
  description = "key .json"
}
