resource "kubernetes_pod" "prometheus" {
  metadata {
    name      = "prometheus-server-conf"
    namespace = "${var.namespace}"

    labels {
      app = "prometheus-server"
    }
  }

  spec {
    container {
      name  = "prometheus"
      image = "prom/prometheus:v1.8.2"

      args = [
        "-config.file=/etc/prometheus/prometheus.yml",
        "-storage.local.path=/prometheus/",
      ]

      port {
        container_port = 9090
      }

      volume_mount {
        name       = "prometheus-config-volume"
        mount_path = "/etc/prometheus/"
        name       = "prometheus-storage-volume"
        mount_path = "/prometheus/"
      }
    }

    volume {
      name = "prometheus-config-volume"

      config_map {
        name = "prometheus-server-conf"
      }

      name = "prometheus-storage-volume"
    }
  }
}
