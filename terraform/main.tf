provider "yandex" {
  token     = "AQAAAABX-5zoAATuwb9Q0WRMN0WJiFnfWMJbCMA"
  cloud_id  = "b1geeigb8tm4mbhthlqf"
  folder_id = "b1g6rdsrvhrut8j2904c"
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "app" {
  name = "reddit-app"
  platform_id = "standard-v1"
  metadata = {
  ssh-keys = "ubuntu:${file("~/.ssh/appuser.pub")}"
  }

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашем задании
      image_id = "fd8kr0jsnv3dtgdggmfp"
    }
  }

  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = "e9bfqiqo25j3uov6r86q"
    nat       = true
  }

  connection {
    type = "ssh"
    host = yandex_compute_instance.app.network_interface.0.nat_ip_address
    user = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file("~/.ssh/appuser")
  }

  provisioner "file" {
    source = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}
