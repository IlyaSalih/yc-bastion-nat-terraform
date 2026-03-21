variable "cloud_id" {
  description = "ID облака"
  type        = string
  default     = "b1gdtifcc9vjrqnd253l"
}

variable "folder_id" {
  description = "ID каталога"
  type        = string
  default     = "b1gaot008hoifqv3mgjr"
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
  description = "Внешний IP рабочей станции администратора"
  type        = string
  default     = "77.238.232.173"
}