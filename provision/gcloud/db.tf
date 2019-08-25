resource "random_id" "db-instance" {
  byte_length = 4
}

resource "google_sql_database_instance" "master" {
  name             = "master-instance-${random_id.db-instance.hex}"
  database_version = "${var.sql_db_version}"
  region           = "${var.region}"
  depends_on = [
    "google_project_service.sqladmin"
  ]
  settings {
    availability_type = "${var.availability_type}"
    tier              = "${var.sql_instance_size}"
    ip_configuration {
      ipv4_enabled    = "false"
      private_network = "${google_compute_network.vpc_default.self_link}"
    }
    backup_configuration {
      enabled    = true
      start_time = "00:00"
    }
    location_preference {
      zone = "${var.region}-${var.sql_master_zone}"
    }
  }
  timeouts {
    create = "20m"
    update = "30m"
  }
}

resource "google_sql_database_instance" "replica" {
  depends_on = [
    "google_sql_database_instance.master",
  ]

  name                 = "replica-instance-${terraform.workspace}"
  region               = "${var.region}"
  database_version     = "${var.sql_db_version}"
  master_instance_name = "${google_sql_database_instance.master.name}"

  settings {
    tier            = "${var.sql_instance_size}"
    disk_autoresize = true
    ip_configuration {
      ipv4_enabled    = "false"
      private_network = "${google_compute_network.vpc_default.self_link}"
    }
    location_preference {
      zone = "${var.region}-${var.sql_replica_zone}"
    }
  }
}

resource "random_string" "database_password" {
  length  = 16
  special = false
}

resource "google_sql_user" "master-user" {
  name     = "user"
  instance = "${google_sql_database_instance.master.name}"
  password = "${random_string.database_password.result}"
}

resource "google_sql_database" "db-name" {
  name     = "database_name"
  instance = "${google_sql_database_instance.master.name}"
}

resource "google_project_service" "sqladmin" {
  service            = "sqladmin.googleapis.com"
  disable_on_destroy = false
}
