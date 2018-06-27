#----------------------------------------------------------------
resource "kubernetes_service" "alertmanager" {
  metadata {
    name      = "alertmanager"
    namespace = "${var.namespace}"
  }

  spec {
    selector {
      app = "alertmanager"
    }

    type = "NodePort"

    port {
      port        = 9093
      target_port = 9093
    }
  }
}

#----------------------------------------------------------------
resource "kubernetes_pod" "alertmanager" {
  metadata {
    name      = "alertmanager"
    namespace = "${var.namespace}"

    labels {
      app = "alertmanager"
    }
  }

  spec {
    container {
      name  = "alertmanager"
      image = "prom/alertmanager:v0.5.0"

      args = [
        "-config.file=/etc/alertmanager/alertmanager.yml",
        "-storage.path=/alertmanager",
        "-web.external-url=http://<URL>:9093",
      ]

      port {
        container_port = 9090
      }

      volume_mount {
        name       = "data"
        mount_path = "/alertmanager"
        name       = "config-volume"
        mount_path = "/etc/alertmanager"
      }

      resources {
        requests {
          cpu    = "10m"
          memory = "10Mi"
        }

        limits {
          cpu    = "50m"
          memory = "150Mi"
        }
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
