## Kubernetes Cluster setup
## Install and configure AWS cli and Terraform 
# What is AWS CLI
   It is used for managaing aws service through command line interface , instead of doing it in graphics we can simple run command to access aws services
# Benefits of using CLI
# Pre-Requisites and LAB setup
    - Required Python 2.6 above version 
    - Required pip
    - Required awscli installation
# Installation
    # yum install python python-pip awscli

# aws configure
    AWS Access Key ID : AWS_ACCESS_KEY                 (# THIS IS USERNAME)
    AWS Secret Access Key : AWS_SECRET_ACCESS_KEY      (# THIS IS PASSWORD)
    Default region name : us-east-1
    Default output format : json                       (it is 3 types - json,text,table)

# cat ~/.aws/config
    [default]
    output = json
    region = us-east-1
# cat ~/.aws/credentials
    aws_access_key_id = *************
    aws_secret_access_key = **************

# Validating connection to configure aws account
    # aws ec2 describe-regions --output table
```
----------------------------------------------------------
|                     DescribeRegions                    |
+--------------------------------------------------------+
||                        Regions                       ||
|+-----------------------------------+------------------+|
||             Endpoint              |   RegionName     ||
|+-----------------------------------+------------------+|
||  ec2.ap-south-1.amazonaws.com     |  ap-south-1      ||
||  ec2.eu-west-3.amazonaws.com      |  eu-west-3       ||
||  ec2.eu-west-2.amazonaws.com      |  eu-west-2       ||
||  ec2.eu-west-1.amazonaws.com      |  eu-west-1       ||
||  ec2.ap-northeast-2.amazonaws.com |  ap-northeast-2  ||
||  ec2.ap-northeast-1.amazonaws.com |  ap-northeast-1  ||
||  ec2.sa-east-1.amazonaws.com      |  sa-east-1       ||
||  ec2.ca-central-1.amazonaws.com   |  ca-central-1    ||
||  ec2.ap-southeast-1.amazonaws.com |  ap-southeast-1  ||
||  ec2.ap-southeast-2.amazonaws.com |  ap-southeast-2  ||
||  ec2.eu-central-1.amazonaws.com   |  eu-central-1    ||
||  ec2.us-east-1.amazonaws.com      |  us-east-1       ||
||  ec2.us-east-2.amazonaws.com      |  us-east-2       ||
||  ec2.us-west-1.amazonaws.com      |  us-west-1       ||
||  ec2.us-west-2.amazonaws.com      |  us-west-2       ||
|+-----------------------------------+------------------+|
```
# Always setup aws keys in .bashrc
    # vim ~/.bashrc
    export AWS_CONGIG_FILE=$HOME/.aws/congig
                or
    ## A P MALLA AWS Keys ####
    AWS_SECRET_ACCESS_KEY=********************
    AWS_ACCESS_KEY=*********************
## To Configure Kubernetes Cluster:
```
$ git clone git@github.com:apmalla/kubernetes.git
$ cd terraform
$ terraform init
$ terraform plan
$terraform apply
```
# ToDo
```
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
```

