output "bastion_external_ip" {
  description = "Внешний IP bastion-хоста"
  value       = yandex_compute_instance.bastion.network_interface[0].nat_ip_address
}

output "web1_internal_ip" {
  description = "Внутренний IP web-1"
  value       = yandex_compute_instance.web1.network_interface[0].ip_address
}

output "web2_internal_ip" {
  description = "Внутренний IP web-2"
  value       = yandex_compute_instance.web2.network_interface[0].ip_address
}

output "ssh_bastion" {
  description = "Подключение к bastion"
  value       = "ssh ubuntu@${yandex_compute_instance.bastion.network_interface[0].nat_ip_address}"
}

output "ssh_web1" {
  description = "Подключение к web-1 через bastion"
  value       = "ssh -J ubuntu@${yandex_compute_instance.bastion.network_interface[0].nat_ip_address} ubuntu@${yandex_compute_instance.web1.network_interface[0].ip_address}"
}

output "ssh_web2" {
  description = "Подключение к web-2 через bastion"
  value       = "ssh -J ubuntu@${yandex_compute_instance.bastion.network_interface[0].nat_ip_address} ubuntu@${yandex_compute_instance.web2.network_interface[0].ip_address}"
}
