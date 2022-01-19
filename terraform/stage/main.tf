provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

module "vpc" {
  source       = "../modules/vpc"
  zone         = var.zone
  network_name = var.network_name
}

module "app" {
  source            = "../modules/app"
  app_instance_name = var.app_instance_name
  public_key_path   = var.public_key_path
  app_disk_image    = var.app_disk_image
  subnet_id         = module.vpc.subnet_id
  database_url      = module.db.internal_ip_address_db
}

module "db" {
  source           = "../modules/db"
  db_instance_name = var.db_instance_name
  public_key_path  = var.public_key_path
  db_disk_image    = var.db_disk_image
  subnet_id        = module.vpc.subnet_id
}
