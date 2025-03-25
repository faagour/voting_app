# Project ID in Google Cloud
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

# Region where GKE cluster will be deployed
variable "region" {
  description = "Region in GCP where the GKE cluster is located"
  type        = string
  default     = "us-central1"
}

# Zone where GKE cluster will be deployed
variable "zone" {
  description = "Zone in GCP where the GKE cluster is located"
  type        = string
  default     = "us-central1-a"
}

# Cluster name for the GKE cluster
variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "voting-cluster"
}

# Node machine type for the GKE cluster
variable "machine_type" {
  description = "Machine type for the GKE nodes"
  type        = string
  default     = "e2-medium"
}

# Number of nodes in the GKE cluster
variable "node_count" {
  description = "Number of nodes in the GKE cluster"
  type        = number
  default     = 3
}
