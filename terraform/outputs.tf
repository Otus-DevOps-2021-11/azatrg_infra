output "external_ip_address_app" {
  value = yandex_compute_instance.app[0].network_interface.0.nat_ip_address
}
output "nlb_listener_ip_address" {
  value = flatten(yandex_lb_network_load_balancer.nlb.listener[*].external_address_spec.*.address)[0]
}
