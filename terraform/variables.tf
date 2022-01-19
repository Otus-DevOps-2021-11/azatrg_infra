variable service_account_key_file {
  description = "key .json"
}
variable cloud_id {
  description = "Cloud"
}
variable folder_id {
  description = "Folder"
}
variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable "s3_access_key" {
  description = "S3 access key"
}
variable "s3_secret_key" {
  description = "S3 secret key"
}
