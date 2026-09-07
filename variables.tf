variable "cloud_id" {
  description = "ID облака"
  type        = string
  # значение по умолчанию не задано намеренно — передавайте своё через
  # terraform.tfvars или -var при запуске
}

variable "folder_id" {
  description = "ID каталога"
  type        = string
  # значение по умолчанию не задано намеренно — передавайте своё через
  # terraform.tfvars или -var при запуске
}

# Ubuntu 22.04 LTS image id (ru-central1)
variable "image_id" {
  description = "ID образа для ВМ"
  type        = string
  default     = "fd8ciuqfa001h8s9sa7i" # ubuntu-22-04-lts
}

variable "vm_resources" {
  description = "Ресурсы для web-ВМ"
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
  })
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }
}

variable "bastion_resources" {
  description = "Ресурсы для bastion-хоста"
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
  })
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }
}

variable "ssh_public_key_path" {
  description = "Путь до публичного SSH-ключа"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "admin_ip" {
  description = "Внешний IP рабочей станции администратора (узнать: curl ifconfig.me)"
  type        = string
  # значение по умолчанию не задано намеренно — подставьте свой IP
}