terraform {
  backend "gcs" {
    bucket = "bucket-for-vault-tt-ihar"
    prefix  = "terraform/module"
    credentials = "./account.json"
  }
}
