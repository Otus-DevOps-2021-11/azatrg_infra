resource "yandex_compute_instance" "app" {
  name = var.app_instance_name
  labels = {
    tags = var.app_instance_name
  }

  resources {
    core_fraction = 100
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


  connection {
    type  = "ssh"
    host  = "${self.network_interface.0.nat_ip_address}"
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }

  # provisioner "file" {
  #   content     = templatefile("${path.module}/files/puma.service.tmpl", { DATABASE_URL = var.database_url })
  #   destination = "/tmp/puma.service"
  # }

  # provisioner "remote-exec" {
  #   script = "${path.module}/files/db_url.sh"
  # }
}
