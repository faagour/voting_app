
resource "docker_container" "worker" {
    image = "europe-west9-docker.pkg.dev/tuto-terraform-amine/voting-image/worker"
    name  = "worker"
    ports {
        internal = 80
        external = 80
    }
    env = [
        "REDIS_HOST=redis",
        "REDIS_PORT=6379",
        "POSTGRES_HOST=db",
        "POSTGRES_DB=db",
        "POSTGRES_USER=postgres",
        "POSTGRES_PASSWORD=postgres"
    ]
    networks_advanced {
        name = docker_network.back_tier.name
    }
    depends_on = [docker_container.redis, docker_container.db]
}



resource "docker_container" "nginx" {
    image = "europe-west9-docker.pkg.dev/tuto-terraform-amine/voting-image/nginx"
    name  = "nginx"
    ports {
        internal = 8001
        external = 8001
    }
    networks_advanced {
        name = docker_network.front_tier.name
    }
    depends_on = [docker_container.vote]
}

resource "docker_container" "seed" {
    image = "europe-west9-docker.pkg.dev/tuto-terraform-amine/voting-image/seed"
    name  = "seed"
    ports {
        internal = 9000
        external = 9000
    }
    networks_advanced {
        name = docker_network.front_tier.name
    }
    depends_on = [docker_container.nginx]
}