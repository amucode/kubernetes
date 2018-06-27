resource "kubernetes_pod" "kube-state-metrics" {
  metadata {
    name      = "kube-state-metrics"
    namespace = "${var.namespace}"

    labels {
      app = "kube-state-metrics"
    }
  }

  spec {
    container {
      name  = "kube-state-metrics"
      image = "gcr.io/google_containers/kube-state-metrics:v0.3.0"

      port {
        name           = "exporter"
        container_port = 8080
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
  }
}

#-----------------------------------------------------------
resource "kubernetes_service" "prometheus" {
  metadata {
    name      = "kube-state-metrics"
    namespace = "${var.namespace}"

    labels {
      app = "kube-state-metrics"
    }

    annotations {
      "prometheus.io/scrape" = "true"
    }
  }

  spec {
    selector {
      app = "kube-state-metrics"
    }

    type = "NodePort"

    port {
      name = "kube-state-metrics"
      port = 8080
    }
  }
}
