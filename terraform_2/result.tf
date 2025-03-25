resource "kubernetes_deployment" "result" {
  metadata {
    name = "result-deploy"
    labels = {
      app = "result"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "result"
      }
    }

    template {
      metadata {
        labels = {
          app = "result"
        }
      }

      spec {
        container {
          name  = "result"
          image = "europe-west9-docker.pkg.dev/tuto-terraform-amine/voting-image/result"
          ports {
            container_port = 4000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "result" {
  metadata {
    name = "result-service"
  }

  spec {
    selector = {
      app = "result"
    }

    port {
      port        = 4000
      target_port = 4000
    }

    type = "LoadBalancer"
  }
}
