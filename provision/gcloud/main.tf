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

# commonly used variables declaration
variable project_id {}
variable region {}
variable zones {
  type = "list"
}
