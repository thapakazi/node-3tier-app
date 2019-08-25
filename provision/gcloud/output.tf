output "project_id" {
  value = "${var.project_id}"
}

output "cluster_name" {
  value = "${google_container_cluster.primary.name}"
}

output "region" {
  value = "${var.region}"
}

# output "gcn" {
#   value = "${google_compute_network.vpc_default}"
# }

output "database_url" {
  value = "postgresql://${google_sql_user.master-user.name}:${google_sql_user.master-user.password}@${google_sql_database_instance.master.private_ip_address}/${google_sql_database.db-name.name}"
  # sensitive = true
}
