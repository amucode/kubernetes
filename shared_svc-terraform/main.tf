provider "kubernetes" {
  host        = "https://127.0.0.1"
  username    = "admin"
  password    = "XdArWBrvaslmYWkhjo8ec1bdJpEi5jY6"
  config_path = "/Users/amulya/.kube/config"
}

#----------------------------------------------------------------
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

#----------------------------------------------------------------
module "prometheus" {
  source    = "./prometheus"
  namespace = "monitoring"
}

#----------------------------------------------------------------

module "kubestate-metrics" {
  source    = "./kubestate-metrics"
  namespace = "monitoring"
}

#----------------------------------------------------------------
module "node-exporter" {
  source    = "./node-exporter"
  namespace = "monitoring"
}

#----------------------------------------------------------------
module "alertmanager" {
  source    = "./alertmanager"
  namespace = "monitoring"
}

#----------------------------------------------------------------

