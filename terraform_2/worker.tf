resource "kubernetes_deployment" "worker" {
  metadata {
    name = "worker-deploy"
    labels = {
      app = "worker"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "worker"
      }
    }

    template {
      metadata {
        labels = {
          app = "worker"
        }
      }

      spec {
        container {
          name  = "worker"
          image = "europe-west9-docker.pkg.dev/tuto-terraform-amine/voting-image/worker"
          env {
            name  = "REDIS_HOST"
            value = "redis"
          }
          env {
            name  = "REDIS_PORT"
            value = "6379"
          }
          env {
            name  = "POSTGRES_HOST"
            value = "db"
          }
          env {
            name  = "POSTGRES_DB"
            value = "db"
          }
          env {
            name  = "POSTGRES_USER"
            value = "postgres"
          }
          env {
            name  = "POSTGRES_PASSWORD"
            value = "postgres"
          }
          ports {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "worker" {
  metadata {
    name = "worker"
  }

  spec {
    selector = {
      app = "worker"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}
