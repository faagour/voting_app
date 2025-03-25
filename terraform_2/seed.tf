resource "kubernetes_job" "seed" {
  metadata {
    name = "seed"
  }

  spec {
    template {
      metadata {
        labels = {
          app = "seed"
        }
      }

      spec {
        container {
          name  = "seed"
          image = "europe-west9-docker.pkg.dev/tuto-terraform-amine/voting-image/seed"
          ports {
            container_port = 9000
          }
        }

        restart_policy = "Never"
      }
    }
  }
}
