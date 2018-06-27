resource "kubernetes_service" "prometheus" {
  metadata {
    name      = "prometheus-service"
    namespace = "${var.namespace}"

    annotations {
      "prometheus.io/scrape" = "true"
      "prometheus.io/path"   = "/"
      "prometheus.io/port"   = "8080"
    }
  }

  spec {
    selector {
      app = "prometheus"
    }

    type = "NodePort"

    port {
      port        = 8080
      target_port = 9090
    }
  }
}
