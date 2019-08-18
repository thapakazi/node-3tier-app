provider "google"{
  credentials = "${file("keyfile/key.json")}"
  project = "${var.project_id}"
  region = "${var.region}"
}

provider "google-beta"{
  credentials = "${file("keyfile/key.json")}"
  project = "${var.project_id}"
  region = "${var.region}"
}

variable project_id{}
variable region{}
