terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_network" "front_tier" {
    name = "front-tier"
}

resource "docker_network" "back_tier" {
    name = "back-tier"
}

resource "docker_volume" "db_volume" {
    name = "db"
}


resource "docker_container" "redis" {
    image = "redis:alpine"
    name  = "redis"
    ports {
        internal = 6379
        external = 6379
    }
    networks_advanced {
        name = docker_network.back_tier.name
    }
}

resource "docker_container" "db" {
    image = "postgres:alpine"
    name  = "db"
    ports {
        internal = 5432
        external = 5432
    }
    env = [
        "POSTGRES_DB=db",
        "POSTGRES_USER=postgres",
        "POSTGRES_PASSWORD=postgres"
    ]
    volumes {
        volume_name    = docker_volume.db_volume.name
        container_path = "/var/lib/postgresql/data"
    }
    networks_advanced {
        name = docker_network.back_tier.name
    }
}


resource "docker_container" "vote" {
    image = "europe-west9-docker.pkg.dev/tuto-terraform-amine/voting-image/vote"
    name  = "vote"
    ports {
        internal = 5000
        external = 5000
    }
    networks_advanced {
        name = docker_network.front_tier.name
    }
    depends_on = [docker_container.redis]
}

resource "docker_container" "result" {
    image = "europe-west9-docker.pkg.dev/tuto-terraform-amine/voting-image/result"
    name  = "result"
    ports {
        internal = 4000
        external = 4000
    }
    networks_advanced {
        name = docker_network.front_tier.name
    }
    depends_on = [docker_container.db]
}
