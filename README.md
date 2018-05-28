# OnCorps- Kubernetes Cluster setup
## Install and configure AWS cli and Terraform 

* [AWS CLI](https://docs.aws.amazon.com/rekognition/latest/dg/setup-awscli.html) - Install and configure AWS CLI
* [Terraform](https://www.terraform.io/intro/getting-started/install.html)- Install and configure Terrafrom
 

## To Configure Kubernetes Cluster:
```
$ git clone git@github.com:apmalla/kubernetes.git
$ cd terraform
$ terraform init
$ terraform plan
$terraform apply
```
**NOTE:** 
AWS cli should be configured with default profile(account), (or) update provider by adding "profile" in Terraform template.

# ToDo
- [ ] VPC Design 
- [ ] Launch configurations 
- [ ] AutoScaling Groups
- [ ] ELB for Kubernetes API 
- [x] AutoScaling policies 
- [x] Dynamic cluster-name
- [x] coreDNS integration
- [x] Dashboard configurations
- [x] Prometheus configurations
- [x] Advanced NACL and Egress Rules


