output "project_id"{
  value = "${var.project_id}"
}

output "cluster_name"{
  value = "${google_container_cluster.primary.name}"
}

output "region"{
  value = "${var.region}"
}
