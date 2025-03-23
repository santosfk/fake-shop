terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.49.2"
    }
  }
}
resource "digitalocean_kubernetes_cluster" "ecommerce" {
  name   = "ecommerce"
  region = "nyc1"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.32.2-do.0"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    node_count = 2
  }
}

output "kubeconfig" {
    value = digitalocean_kubernetes_cluster.ecommerce.kube_config[0].raw_config
    sensitive = true
}