resource "kubernetes_deployment" "vote" {
  metadata {
    name = "vote-deployment"
    labels = {
      app = "vote"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "vote"
      }
    }

    template {
      metadata {
        labels = {
          app = "vote"
        }
      }

      spec {
        container {
          name  = "vote"
          image = "europe-west9-docker.pkg.dev/tuto-terraform-amine/voting-image/vote"
          ports {
            container_port = 5000
          }
          env {
            name  = "REDIS_HOST"
            value = "redis"
          }
          env {
            name  = "REDIS_PORT"
            value = "6379"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "vote" {
  metadata {
    name = "vote"
  }

  spec {
    selector = {
      app = "vote"
    }

    port {
      port        = 5000
      target_port = 5000
    }

    type = "LoadBalancer"
  }
}
