locals {
  ssh_public_key = file(var.ssh_public_key_path)
}

resource "yandex_compute_instance" "bastion" {
  name        = "bastion"
  hostname    = "bastion"
  zone        = "ru-central1-a"
  platform_id = "standard-v3"

  resources {
    cores         = var.bastion_resources.cores
    memory        = var.bastion_resources.memory
    core_fraction = var.bastion_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 10
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.bastion_subnet.id
    security_group_ids = [yandex_vpc_security_group.bastion_sg.id]
    nat                = true
  }

  metadata = {
    user-data = <<-EOF
      #cloud-config
      users:
        - name: ubuntu
          groups: sudo
          shell: /bin/bash
          sudo: ['ALL=(ALL) NOPASSWD:ALL']
          ssh_authorized_keys:
            - ${local.ssh_public_key}
    EOF
  }
}

resource "yandex_compute_instance" "web1" {
  name        = "web-1"
  hostname    = "web-1"
  zone        = "ru-central1-a"
  platform_id = "standard-v3"

  resources {
    cores         = var.vm_resources.cores
    memory        = var.vm_resources.memory
    core_fraction = var.vm_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 10
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.zone_a.id
    security_group_ids = [yandex_vpc_security_group.internal_sg.id]
    nat                = false
  }

  metadata = {
    user-data = <<-EOF
      #cloud-config
      users:
        - name: ubuntu
          groups: sudo
          shell: /bin/bash
          sudo: ['ALL=(ALL) NOPASSWD:ALL']
          ssh_authorized_keys:
            - ${local.ssh_public_key}
    EOF
  }
}

resource "yandex_compute_instance" "web2" {
  name        = "web-2"
  hostname    = "web-2"
  zone        = "ru-central1-b"
  platform_id = "standard-v3"

  resources {
    cores         = var.vm_resources.cores
    memory        = var.vm_resources.memory
    core_fraction = var.vm_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 10
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.zone_b.id
    security_group_ids = [yandex_vpc_security_group.internal_sg.id]
    nat                = false
  }

  metadata = {
    user-data = <<-EOF
      #cloud-config
      users:
        - name: ubuntu
          groups: sudo
          shell: /bin/bash
          sudo: ['ALL=(ALL) NOPASSWD:ALL']
          ssh_authorized_keys:
            - ${local.ssh_public_key}
    EOF
  }
}
