provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}


resource "yandex_storage_bucket" "test" {
  access_key = var.s3_access_key
  secret_key = var.s3_secret_key
  bucket     = "azatrg-s3-tf-states"
}
