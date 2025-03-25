resource "kubernetes_persistent_volume" "postgres-pv" {
  metadata {
    name = "postgres-pv"
  }

  spec {
    capacity = {
      storage = "1Gi"
    }

    volume_mode = "Filesystem"

    access_modes = ["ReadWriteOnce"]

    persistent_volume_reclaim_policy = "Retain"

    storage_class_name = "manual"

    host_path {
      path = "/mnt/data"
    }
  }
}

resource "kubernetes_persistent_volume_claim" "postgres-pvc" {
  metadata {
    name = "postgres-pvc"
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "1Gi"
      }
    }

    storage_class_name = "manual"

    volume_name = kubernetes_persistent_volume.postgres-pv.metadata[0].name
  }
}
