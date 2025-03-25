# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# Configure the Kubernetes provider
provider "kubernetes" {
  host                   = google_container_cluster.primary.endpoint
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

# Google Cloud client configuration
data "google_client_config" "default" {}

# Create the GKE cluster
resource "google_container_cluster" "primary" {
  name     = "voting-cluster"
  location = var.zone

  initial_node_count = 3

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

# Module to deploy all Kubernetes resources (e.g. deployments, services)
module "deployments" {
  source = "./modules/deployments"
}

# Module for Kubernetes services (e.g. vote, result, redis, etc.)
module "services" {
  source = "./modules/services"
}

# Module for persistent volume claims (PVC)
module "pvc" {
  source = "./pvc"
}
