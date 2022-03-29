resource "yandex_compute_instance" "gitlab" {
  name        = var.gitlab_instance_name
  platform_id = "standard-v3"
  labels = {
    tags = var.gitlab_instance_name
  }

  resources {
    core_fraction = 100
    cores         = 2
    memory        = 6

  }

  boot_disk {
    initialize_params {
      image_id = var.gitlab_disk_image
      type     = var.gitlab_disk_type
      size     = var.gitlab_disk_size
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
  #   source      = "${path.module}/files/mongod.conf"
  #   destination = "/tmp/mongod.conf"
  # }

  # provisioner "remote-exec" {
  #   script = "${path.module}/files/mongod.sh"
  # }
}
