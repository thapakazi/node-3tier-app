resource "random_id" "db-instance" {
  byte_length = 4
}

resource "google_sql_database_instance" "master" {
  name             = "master-instance-${random_id.db-instance.hex}"
  database_version = "POSTGRES_9_6"
  region           = "${google_container_cluster.primary.region}"
  depends_on = [
    "google_project_service.sqladmin"
  ]
  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = "false"
      private_network = "${google_compute_network.vpc_default.self_link}"
    }
  }
  timeouts {
    create = "20m"
    update = "30m"
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

output "database_url" {
  value     = "postgresql://${google_sql_user.master-user.name}:${google_sql_user.master-user.password}@${google_sql_database_instance.master.private_ip_address}/${google_sql_database.db-name.name}"
  sensitive = true
}
