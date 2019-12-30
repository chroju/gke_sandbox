terraform {
  backend "gcs" {
    bucket = "chroju-tf"
    prefix = "nebula/state"
  }
}

resource "google_container_cluster" "nebula" {
  name               = "nebula"
  zone               = "us-central1-a"
  initial_node_count = 2
}

resource "google_container_node_pool" "nebula-pool" {
  name       = "nebula-pool"
  zone       = "us-central1-a"
  cluster    = "${google_container_cluster.nebula.name}"
  node_count = 2

  node_config {
    disk_size_gb = 30
    preemptible  = true
    machine_type = "g1-small"
  }
}
