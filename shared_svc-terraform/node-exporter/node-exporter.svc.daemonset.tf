#----------------------------------------------------------------
resource "kubernetes_service" "node-exporter" {
  metadata {
    name      = "node-exporter"
    namespace = "${var.namespace}"

    annotations {
      "prometheus.io/scrape" = "true"
    }
  }

  spec {
    selector {
      app = "node-exporter"
    }

    type = "clusterIP"

    port {
      port     = 9100
      protocol = "TCP"
    }
  }
}

#----------------------------------------------------------------
resource "kubernetes_pod" "node-exporter" {
  metadata {
    name      = "node-exporter"
    namespace = "${var.namespace}"

    labels {
      app = "node-exporter"
    }
  }

  spec {
    container {
      name  = "kube-state-metrics"
      image = "weaveworks/node_exporter:master-abe8e29"

      port {
        name           = "exporter"
        container_port = 9100
      }

      volume_mount {
        name       = "rootfs"
        mount_path = "/rootfs"
        read_only  = "true"
      }

      resources {
        requests {
          cpu    = "10m"
          memory = "10Mi"
        }

        limits {
          cpu    = "25m"
          memory = "20Mi"
        }
      }
    }

    volume {
      name = "rootfs"
    }
  }
}
