resource "yandex_vpc_network" "app-network" {
  name = var.network_name
}

resource "yandex_vpc_subnet" "app-subnet" {
  name           = "${yandex_vpc_network.app-network.name}"
  zone           = var.zone
  network_id     = "${yandex_vpc_network.app-network.id}"
  v4_cidr_blocks = ["192.168.10.0/24"]
}
