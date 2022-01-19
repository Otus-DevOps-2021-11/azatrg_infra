provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

module "vpc" {
  source = "../modules/vpc"
  zone = var.zone
}

module "app" {
  source          = "../modules/app"
  app_instance_name = var.app_instance_name
  public_key_path = var.public_key_path
  app_disk_image  = var.app_disk_image
  subnet_id       = module.vpc.subnet_id
  database_url = module.db.external_ip_address_db
}

module "db" {
  source          = "../modules/db"
  db_instance_name = var.db_instance_name
  public_key_path = var.public_key_path
  db_disk_image   = var.db_disk_image
  subnet_id       = module.vpc.subnet_id
}

# resource "yandex_compute_instance" "app" {
#   name        = "${var.instance_name}-${count.index + 1}"
#   platform_id = "standard-v1"
#   zone        = var.zone
#   count       = var.instance_count

#   resources {
#     core_fraction = 5
#     cores  = 2
#     memory = 2
#   }

#   boot_disk {
#     initialize_params {
#       # Указать id образа созданного в предыдущем домашем задании
#       image_id = var.image_id
#       type     = "network-ssd"
#     }
#   }

#   network_interface {
#     # Указан id подсети default-ru-central1-a
#     subnet_id = yandex_vpc_subnet.app-subnet.id
#     nat       = true
#   }

#   metadata = {
#     ssh-keys = "ubuntu:${file(var.public_key_path)}"
#   }

#   connection {
#     type  = "ssh"
#     host  = "${self.network_interface.0.nat_ip_address}"
#     user  = "ubuntu"
#     agent = false
#     # путь до приватного ключа
#     private_key = file(var.private_key_path)
#   }

#   # provisioner "file" {
#   #   source      = "files/puma.service"
#   #   destination = "/tmp/puma.service"
#   # }

#   # provisioner "remote-exec" {
#   #   script = "files/deploy.sh"
#   # }
# }
