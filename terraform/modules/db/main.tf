resource "yandex_compute_instance" "db" {
  name = var.db_instance_name
  labels = {
    tags = var.db_instance_name
  }

  resources {
    core_fraction = 100
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.db_disk_image
      type     = var.db_disk_type
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = false
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

  provisioner "file" {
    source      = "${path.module}/files/mongod.conf"
    destination = "/tmp/mongod.conf"
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/mongod.sh"
  }
}
