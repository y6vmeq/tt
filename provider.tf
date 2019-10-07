provider "google" {
  credentials = "../account.json"
  project     = var.project
  region      = var.region
}
