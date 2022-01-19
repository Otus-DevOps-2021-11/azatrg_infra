terraform {

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "azatrg-s3-tf-states"
    region     = "us-east-1"
    key        = "terraform/prod/state/terraform.tfstate"
    access_key = "QS9Msdfdfsdfsdf23423"
    secret_key = "pT1eoJxvvjVMnfsdfdsf232323"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
