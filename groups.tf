resource "yandex_vpc_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "SSH только с рабочей станции администратора"
  network_id  = yandex_vpc_network.main.id

  ingress {
    protocol       = "TCP"
    description    = "SSH от администратора"
    port           = 22
    v4_cidr_blocks = ["${var.admin_ip}/32"]
  }

  egress {
    protocol       = "ANY"
    description    = "Любой исходящий"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "internal_sg" {
  name        = "internal-sg"
  description = "SSH только с bastion, HTTP/HTTPS открыт"
  network_id  = yandex_vpc_network.main.id

  ingress {
    protocol       = "TCP"
    description    = "SSH с подсети bastion"
    port           = 22
    v4_cidr_blocks = ["192.168.1.0/24"]
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTPS"
    port           = 443
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "ANY"
    description    = "Исходящий через NAT Gateway"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
