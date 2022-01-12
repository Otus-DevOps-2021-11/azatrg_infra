resource "yandex_compute_instance" "app" {
  name = var.app_instance_name

  labels = {
    tags = var.app_instance_name
  }
  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
      type     = var.app_disk_type
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}