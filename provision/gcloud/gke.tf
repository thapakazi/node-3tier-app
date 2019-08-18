resource "random_id" "gke-cluster" {
  byte_length = 4
}
resource "google_container_cluster" "primary" {
  name           = "node-3tier-app-${random_id.gke-cluster.hex}"
  location       = "${var.region}"
  node_locations = ["asia-south1-a"]

  remove_default_node_pool = true
  initial_node_count       = 1
  depends_on = [
    "google_project_service.container"
  ]

  ip_allocation_policy {
    use_ip_aliases = true
  }
}

resource "google_container_node_pool" "primary_nodes"{
  name = "my-node-pool"
  location = "${google_container_cluster.primary.location}"
  cluster = "${google_container_cluster.primary.name}"
  node_count = 2
  version = "${google_container_cluster.primary.master_version}"

  node_config{
    machine_type = "n1-standard-1"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

resource "google_project_service" "container"{
  service = "container.googleapis.com"
  disable_on_destroy = false
}


