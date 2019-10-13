# verisioning, we will #reviseit later
# terraform {
#   required_version = ">= 0.12, < 0.13"
# }

provider "google" {
  credentials = "${file("keyfile/${var.project_id}.json")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}

provider "google-beta" {
  credentials = "${file("keyfile/${var.project_id}.json")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}

module "k8s" {
  source         = "../../../modules/services/k8s"
  project_id        = "${var.project_id}"
  region         = "${var.region}"
  zones           = "${var.zones}"
  instance_type  = "n1-standard-1"
  min_node_count = 1
  max_node_count = 3
}
