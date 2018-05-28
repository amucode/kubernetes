terraform {
  backend "s3" {
    bucket = "${var.bucket_name}"
    key    = "terraform/terraform.tfstate"
    region = "${var.region}"
  }
}

provider "aws" {
  region = "${var.region}"
}

# ############################################AUTO SCCALING GROUPS ATTACH TO ELB##########################

resource "aws_autoscaling_attachment" "master-us-east-1a-masters-oncorps-k8s-local" {
  elb                    = "${aws_elb.api-oncorps-k8s-local.id}"
  autoscaling_group_name = "${aws_autoscaling_group.master-us-east-1a-masters-oncorps-k8s-local.id}"
}

resource "aws_autoscaling_attachment" "master-us-east-1b-masters-oncorps-k8s-local" {
  elb                    = "${aws_elb.api-oncorps-k8s-local.id}"
  autoscaling_group_name = "${aws_autoscaling_group.master-us-east-1b-masters-oncorps-k8s-local.id}"
}

resource "aws_autoscaling_attachment" "master-us-east-1c-masters-oncorps-k8s-local" {
  elb                    = "${aws_elb.api-oncorps-k8s-local.id}"
  autoscaling_group_name = "${aws_autoscaling_group.master-us-east-1c-masters-oncorps-k8s-local.id}"
}

# ############################################AUTO SCCALING GROUPS##########################

resource "aws_autoscaling_group" "master-us-east-1a-masters-oncorps-k8s-local" {
  name                 = "master-us-east-1a.masters.oncorps.k8s.local"
  launch_configuration = "${aws_launch_configuration.master-us-east-1a-masters-oncorps-k8s-local.id}"
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.master-us-east-1a-oncorps-k8s-local.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "${var.Name}"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-${var.region}a.masters.${var.Name}"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-${var.region}a"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "master-us-east-1b-masters-oncorps-k8s-local" {
  name                 = "master-us-east-1b.masters.${var.Name}"
  launch_configuration = "${aws_launch_configuration.master-us-east-1b-masters-oncorps-k8s-local.id}"
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.master-us-east-1b-oncorps-k8s-local.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "${var.Name}"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-${var.region}b.masters.${var.Name}"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-${var.region}b"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "master-us-east-1c-masters-oncorps-k8s-local" {
  name                 = "master-us-east-1c.masters.${var.Name}"
  launch_configuration = "${aws_launch_configuration.master-us-east-1c-masters-oncorps-k8s-local.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.master-us-east-1c-oncorps-k8s-local.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "${var.Name}"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-${var.region}c.masters.${var.Name}"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-${var.region}c"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-oncorps-k8s-local" {
  name                 = "nodes.oncorps.${var.Name}"
  launch_configuration = "${aws_launch_configuration.nodes-oncorps-k8s-local.id}"
  max_size             = 6
  min_size             = 3
  vpc_zone_identifier  = ["${aws_subnet.node-us-east-1a-oncorps-k8s-local.id}", "${aws_subnet.node-us-east-1b-oncorps-k8s-local.id}", "${aws_subnet.node-us-east-1c-oncorps-k8s-local.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "${var.Name}"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.${var.Name}"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

# ######################################AUTO SCALING GROUP FOR JUMP HOST#################

resource "aws_autoscaling_group" "jump-hosts-oncorps-k8s-local" {
  name                 = "jump-hosts.${var.Name}"
  launch_configuration = "${aws_launch_configuration.jump-host-oncorps-k8s-local.id}"
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.utility-us-east-1a-oncorps-k8s-local.id}", "${aws_subnet.utility-us-east-1b-oncorps-k8s-local.id}", "${aws_subnet.utility-us-east-1c-oncorps-k8s-local.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "${var.Name}"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "jump-host.${var.Name}"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"

  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

# ######################EBS Volumes for ETCD#######################
resource "aws_ebs_volume" "a-etcd-events-oncorps-k8s-local" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "a.etcd-events.${var.Name}"
    "k8s.io/etcd/events"                      = "a/a,b,c"
    "k8s.io/role/master"                      = "1"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
  }
}

resource "aws_ebs_volume" "a-etcd-main-oncorps-k8s-local" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "a.etcd-main.${var.Name}"
    "k8s.io/etcd/main"                        = "a/a,b,c"
    "k8s.io/role/master"                      = "1"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
  }
}

resource "aws_ebs_volume" "b-etcd-events-oncorps-k8s-local" {
  availability_zone = "us-east-1b"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "b.etcd-events.${var.Name}"
    "k8s.io/etcd/events"                      = "b/a,b,c"
    "k8s.io/role/master"                      = "1"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
  }
}

resource "aws_ebs_volume" "b-etcd-main-oncorps-k8s-local" {
  availability_zone = "us-east-1b"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "b.etcd-main.${var.Name}"
    "k8s.io/etcd/main"                        = "b/a,b,c"
    "k8s.io/role/master"                      = "1"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
  }
}

resource "aws_ebs_volume" "c-etcd-events-oncorps-k8s-local" {
  availability_zone = "us-east-1c"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "c.etcd-events.${var.Name}"
    "k8s.io/etcd/events"                      = "c/a,b,c"
    "k8s.io/role/master"                      = "1"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
  }
}

resource "aws_ebs_volume" "c-etcd-main-oncorps-k8s-local" {
  availability_zone = "us-east-1c"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "c.etcd-main.${var.Name}"
    "k8s.io/etcd/main"                        = "c/a,b,c"
    "k8s.io/role/master"                      = "1"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
  }
}

# #########################EPI FOR NAT INSTANCES##########################
resource "aws_eip" "us-east-1a-oncorps-k8s-local" {
  vpc = true

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "${var.region}a.${var.Name}"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
  }
}

resource "aws_elb" "api-oncorps-k8s-local" {
  name = "api-oncorps-k8s-local-ub64gk"

  listener = {
    instance_port     = 443
    instance_protocol = "TCP"
    lb_port           = 443
    lb_protocol       = "TCP"
  }

  security_groups = ["${aws_security_group.api-elb-oncorps-k8s-local.id}"]
  subnets         = ["${aws_subnet.utility-us-east-1a-oncorps-k8s-local.id}", "${aws_subnet.utility-us-east-1b-oncorps-k8s-local.id}", "${aws_subnet.utility-us-east-1c-oncorps-k8s-local.id}"]

  health_check = {
    target              = "SSL:443"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    timeout             = 5
  }

  idle_timeout = 300

  tags = {
    KubernetesCluster = "${var.Name}"
    Name              = "api.${var.Name}"
  }
}

resource "aws_iam_instance_profile" "masters-oncorps-k8s-local" {
  name = "masters.oncorps.k8s.local"
  role = "${aws_iam_role.masters-oncorps-k8s-local.name}"
}

resource "aws_iam_instance_profile" "nodes-oncorps-k8s-local" {
  name = "nodes.oncorps.k8s.local"
  role = "${aws_iam_role.nodes-oncorps-k8s-local.name}"
}

resource "aws_iam_role" "masters-oncorps-k8s-local" {
  name               = "masters.oncorps.k8s.local"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.oncorps.k8s.local_policy")}"
}

resource "aws_iam_role" "nodes-oncorps-k8s-local" {
  name               = "nodes.oncorps.k8s.local"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.oncorps.k8s.local_policy")}"
}

resource "aws_iam_role_policy" "masters-oncorps-k8s-local" {
  name   = "masters.oncorps.k8s.local"
  role   = "${aws_iam_role.masters-oncorps-k8s-local.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.oncorps.k8s.local_policy")}"
}

resource "aws_iam_role_policy" "nodes-oncorps-k8s-local" {
  name   = "nodes.oncorps.k8s.local"
  role   = "${aws_iam_role.nodes-oncorps-k8s-local.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.oncorps.k8s.local_policy")}"
}

resource "aws_internet_gateway" "oncorps-k8s-local" {
  vpc_id = "${aws_vpc.oncorps-k8s-local.id}"

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "${var.Name}"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
  }
}

resource "aws_key_pair" "kubernetes-oncorps-k8s-local-d02732f1485df0fa57c85e1ee6f06b63" {
  key_name   = "kubernetes.oncorps.k8s.local-d0:27:32:f1:48:5d:f0:fa:57:c8:5e:1e:e6:f0:6b:63"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.oncorps.k8s.local-d02732f1485df0fa57c85e1ee6f06b63_public_key")}"
}

resource "aws_launch_configuration" "master-us-east-1a-masters-oncorps-k8s-local" {
  name_prefix                 = "master-us-east-1a.masters.${var.Name}"
  image_id                    = "ami-b0c6ccca"
  instance_type               = "t2.medium"
  key_name                    = "${aws_key_pair.kubernetes-oncorps-k8s-local-d02732f1485df0fa57c85e1ee6f06b63.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-oncorps-k8s-local.id}"
  security_groups             = ["${aws_security_group.masters-oncorps-k8s-local.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-east-1a.masters.oncorps.k8s.local_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 25
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "master-us-east-1b-masters-oncorps-k8s-local" {
  name_prefix                 = "master-us-east-1b.masters.${var.Name}"
  image_id                    = "ami-b0c6ccca"
  instance_type               = "t2.medium"
  key_name                    = "${aws_key_pair.kubernetes-oncorps-k8s-local-d02732f1485df0fa57c85e1ee6f06b63.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-oncorps-k8s-local.id}"
  security_groups             = ["${aws_security_group.masters-oncorps-k8s-local.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-east-1b.masters.oncorps.k8s.local_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 25
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "master-us-east-1c-masters-oncorps-k8s-local" {
  name_prefix                 = "master-us-east-1c.masters.${var.Name}"
  image_id                    = "ami-b0c6ccca"
  instance_type               = "t2.medium"
  key_name                    = "${aws_key_pair.kubernetes-oncorps-k8s-local-d02732f1485df0fa57c85e1ee6f06b63.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-oncorps-k8s-local.id}"
  security_groups             = ["${aws_security_group.masters-oncorps-k8s-local.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-east-1c.masters.oncorps.k8s.local_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 25
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-oncorps-k8s-local" {
  name_prefix                 = "nodes.${var.Name}"
  image_id                    = "ami-b0c6ccca"
  instance_type               = "t2.medium"
  key_name                    = "${aws_key_pair.kubernetes-oncorps-k8s-local-d02732f1485df0fa57c85e1ee6f06b63.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-oncorps-k8s-local.id}"
  security_groups             = ["${aws_security_group.nodes-oncorps-k8s-local.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.oncorps.k8s.local_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 40
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

# #############################################################

resource "aws_launch_configuration" "jump-host-oncorps-k8s-local" {
  name_prefix                 = "jump-host.${var.Name}"
  image_id                    = "ami-f0df538f"
  instance_type               = "t2.small"
  key_name                    = "${aws_key_pair.kubernetes-oncorps-k8s-local-d02732f1485df0fa57c85e1ee6f06b63.id}"
  security_groups             = ["${aws_security_group.jump-host-oncorps-k8s-local.id}"]
  associate_public_ip_address = true

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 30
    delete_on_termination = false
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

# #############################################################

resource "aws_nat_gateway" "us-east-1a-oncorps-k8s-local" {
  allocation_id = "${aws_eip.us-east-1a-oncorps-k8s-local.id}"
  subnet_id     = "${aws_subnet.utility-us-east-1a-oncorps-k8s-local.id}"

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "${var.region}a.${var.Name}"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
  }
}

resource "aws_route" "public-0-0-0-0--0" {
  route_table_id         = "${aws_route_table.public-oncorps-k8s-local.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.oncorps-k8s-local.id}"
}

resource "aws_route" "private-0-0-0-0--0" {
  route_table_id         = "${aws_route_table.private-oncorps-k8s-local.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.us-east-1a-oncorps-k8s-local.id}"
}

resource "aws_route_table" "public-oncorps-k8s-local" {
  vpc_id = "${aws_vpc.oncorps-k8s-local.id}"

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "public-${var.Name}"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
    "kubernetes.io/kops/role"                 = "public"
  }
}

resource "aws_route_table" "private-oncorps-k8s-local" {
  vpc_id = "${aws_vpc.oncorps-k8s-local.id}"

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "private.${var.Name}"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
    "kubernetes.io/kops/role"                 = "private"
  }
}

########################################Private Subnet Association #####################################
resource "aws_route_table_association" "master-us-east-1a-oncorps-k8s-local" {
  subnet_id      = "${aws_subnet.master-us-east-1a-oncorps-k8s-local.id}"
  route_table_id = "${aws_route_table.private-oncorps-k8s-local.id}"
}

resource "aws_route_table_association" "master-us-east-1b-oncorps-k8s-local" {
  subnet_id      = "${aws_subnet.master-us-east-1b-oncorps-k8s-local.id}"
  route_table_id = "${aws_route_table.private-oncorps-k8s-local.id}"
}

resource "aws_route_table_association" "master-us-east-1c-oncorps-k8s-local" {
  subnet_id      = "${aws_subnet.master-us-east-1c-oncorps-k8s-local.id}"
  route_table_id = "${aws_route_table.private-oncorps-k8s-local.id}"
}

resource "aws_route_table_association" "node-us-east-1a-oncorps-k8s-local" {
  subnet_id      = "${aws_subnet.node-us-east-1a-oncorps-k8s-local.id}"
  route_table_id = "${aws_route_table.private-oncorps-k8s-local.id}"
}

resource "aws_route_table_association" "node-us-east-1b-oncorps-k8s-local" {
  subnet_id      = "${aws_subnet.node-us-east-1b-oncorps-k8s-local.id}"
  route_table_id = "${aws_route_table.private-oncorps-k8s-local.id}"
}

resource "aws_route_table_association" "node-us-east-1c-oncorps-k8s-local" {
  subnet_id      = "${aws_subnet.node-us-east-1c-oncorps-k8s-local.id}"
  route_table_id = "${aws_route_table.private-oncorps-k8s-local.id}"
}

########################Public Subnet Association ########################

resource "aws_route_table_association" "utils-us-east-1a-oncorps-k8s-local" {
  subnet_id      = "${aws_subnet.utility-us-east-1a-oncorps-k8s-local.id}"
  route_table_id = "${aws_route_table.public-oncorps-k8s-local.id}"
}

resource "aws_route_table_association" "utils-us-east-1b-oncorps-k8s-local" {
  subnet_id      = "${aws_subnet.utility-us-east-1b-oncorps-k8s-local.id}"
  route_table_id = "${aws_route_table.public-oncorps-k8s-local.id}"
}

resource "aws_route_table_association" "utils-us-east-1c-oncorps-k8s-local" {
  subnet_id      = "${aws_subnet.utility-us-east-1c-oncorps-k8s-local.id}"
  route_table_id = "${aws_route_table.public-oncorps-k8s-local.id}"
}

################################# SEC Groups  ############################################
resource "aws_security_group" "api-elb-oncorps-k8s-local" {
  name        = "api-elb.${var.Name}"
  vpc_id      = "${aws_vpc.oncorps-k8s-local.id}"
  description = "Security group for api ELB"

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "api-elb.${var.Name}"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
  }
}

resource "aws_security_group" "masters-oncorps-k8s-local" {
  name        = "masters.${var.Name}"
  vpc_id      = "${aws_vpc.oncorps-k8s-local.id}"
  description = "Security group for masters"

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "masters.${var.Name}"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
  }
}

resource "aws_security_group" "nodes-oncorps-k8s-local" {
  name        = "nodes.${var.Name}"
  vpc_id      = "${aws_vpc.oncorps-k8s-local.id}"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "nodes.${var.Name}"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
  }
}

resource "aws_security_group" "jump-host-oncorps-k8s-local" {
  name        = "jump-host.${var.Name}"
  vpc_id      = "${aws_vpc.oncorps-k8s-local.id}"
  description = "Security group for Jump-hosts"

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "jump-host.${var.Name}"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
  }
}

resource "aws_security_group_rule" "jump-host-access" {
  type              = "ingress"
  security_group_id = "${aws_security_group.jump-host-oncorps-k8s-local.id}"
  from_port         = 3389
  to_port           = 3389
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "jump-host-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.jump-host-oncorps-k8s-local.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-oncorps-k8s-local.id}"
  source_security_group_id = "${aws_security_group.masters-oncorps-k8s-local.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-oncorps-k8s-local.id}"
  source_security_group_id = "${aws_security_group.masters-oncorps-k8s-local.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-oncorps-k8s-local.id}"
  source_security_group_id = "${aws_security_group.nodes-oncorps-k8s-local.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "api-elb-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.api-elb-oncorps-k8s-local.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https-api-elb-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.api-elb-oncorps-k8s-local.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https-elb-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-oncorps-k8s-local.id}"
  source_security_group_id = "${aws_security_group.api-elb-oncorps-k8s-local.id}"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-oncorps-k8s-local.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-oncorps-k8s-local.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-protocol-ipip" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-oncorps-k8s-local.id}"
  source_security_group_id = "${aws_security_group.nodes-oncorps-k8s-local.id}"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "4"
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-oncorps-k8s-local.id}"
  source_security_group_id = "${aws_security_group.nodes-oncorps-k8s-local.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4001" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-oncorps-k8s-local.id}"
  source_security_group_id = "${aws_security_group.nodes-oncorps-k8s-local.id}"
  from_port                = 2382
  to_port                  = 4001
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-oncorps-k8s-local.id}"
  source_security_group_id = "${aws_security_group.nodes-oncorps-k8s-local.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-oncorps-k8s-local.id}"
  source_security_group_id = "${aws_security_group.nodes-oncorps-k8s-local.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-oncorps-k8s-local.id}"
  source_security_group_id = "${aws_security_group.jump-host-oncorps-k8s-local.id}"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-oncorps-k8s-local.id}"
  source_security_group_id = "${aws_security_group.jump-host-oncorps-k8s-local.id}"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

###### Allow Jump host to access all the servers in cluster#############
##TO MASTERS
resource "aws_security_group_rule" "jump-host-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-oncorps-k8s-local.id}"
  source_security_group_id = "${aws_security_group.jump-host-oncorps-k8s-local.id}"
  from_port                = 1
  to_port                  = 65534
  protocol                 = "-1"
}

##TO NODES
resource "aws_security_group_rule" "jump-host-to-nodes" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-oncorps-k8s-local.id}"
  source_security_group_id = "${aws_security_group.jump-host-oncorps-k8s-local.id}"
  from_port                = 1
  to_port                  = 65534
  protocol                 = "-1"
}

resource "aws_subnet" "master-us-east-1a-oncorps-k8s-local" {
  vpc_id            = "${aws_vpc.oncorps-k8s-local.id}"
  cidr_block        = "${var.master_subnet_1a_cidr}"
  availability_zone = "${var.region}a"

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "master-${var.region}a.${var.Name}"
    SubnetType                                = "Master"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
    "kubernetes.io/role/elb"                  = "1"
  }
}

resource "aws_subnet" "master-us-east-1b-oncorps-k8s-local" {
  vpc_id            = "${aws_vpc.oncorps-k8s-local.id}"
  cidr_block        = "${var.master_subnet_1b_cidr}"
  availability_zone = "${var.region}b"

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "master-${var.region}b.${var.Name}"
    SubnetType                                = "Master"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
    "kubernetes.io/role/elb"                  = "1"
  }
}

resource "aws_subnet" "master-us-east-1c-oncorps-k8s-local" {
  vpc_id            = "${aws_vpc.oncorps-k8s-local.id}"
  cidr_block        = "${var.master_subnet_1c_cidr}"
  availability_zone = "${var.region}c"

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "master-${var.region}c.${var.Name}"
    SubnetType                                = "Master"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
    "kubernetes.io/role/elb"                  = "1"
  }
}

#############################################################NODE Subnets ##############################################################

resource "aws_subnet" "node-us-east-1a-oncorps-k8s-local" {
  vpc_id            = "${aws_vpc.oncorps-k8s-local.id}"
  cidr_block        = "${var.node_subnet_1a_cidr}"
  availability_zone = "${var.region}a"

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "node-${var.region}a.${var.Name}"
    SubnetType                                = "Node"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
    "kubernetes.io/role/elb"                  = "1"
  }
}

resource "aws_subnet" "node-us-east-1b-oncorps-k8s-local" {
  vpc_id            = "${aws_vpc.oncorps-k8s-local.id}"
  cidr_block        = "${var.node_subnet_1b_cidr}"
  availability_zone = "${var.region}b"

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "node-${var.region}b.${var.Name}"
    SubnetType                                = "Node"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
    "kubernetes.io/role/elb"                  = "1"
  }
}

resource "aws_subnet" "node-us-east-1c-oncorps-k8s-local" {
  vpc_id            = "${aws_vpc.oncorps-k8s-local.id}"
  cidr_block        = "${var.node_subnet_1c_cidr}"
  availability_zone = "${var.region}c"

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "node-${var.region}c.${var.Name}"
    SubnetType                                = "Node"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
    "kubernetes.io/role/elb"                  = "1"
  }
}

resource "aws_subnet" "utility-us-east-1a-oncorps-k8s-local" {
  vpc_id            = "${aws_vpc.oncorps-k8s-local.id}"
  cidr_block        = "${var.utility_subnet_1a_cidr}"
  availability_zone = "${var.region}a"

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "utility-${var.region}a.${var.Name}"
    SubnetType                                = "Utility"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
    "kubernetes.io/role/elb"                  = "1"
  }
}

resource "aws_subnet" "utility-us-east-1b-oncorps-k8s-local" {
  vpc_id            = "${aws_vpc.oncorps-k8s-local.id}"
  cidr_block        = "${var.utility_subnet_1b_cidr}"
  availability_zone = "${var.region}b"

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "utility-${var.region}b.${var.Name}"
    SubnetType                                = "Utility"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
    "kubernetes.io/role/elb"                  = "1"
  }
}

resource "aws_subnet" "utility-us-east-1c-oncorps-k8s-local" {
  vpc_id            = "${aws_vpc.oncorps-k8s-local.id}"
  cidr_block        = "${var.utility_subnet_1c_cidr}"
  availability_zone = "${var.region}c"

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "utility-${var.region}c.${var.Name}"
    SubnetType                                = "Utility"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
    "kubernetes.io/role/elb"                  = "1"
  }
}

resource "aws_vpc" "oncorps-k8s-local" {
  cidr_block           = "${var.cidr_block}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "${var.Name}"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "oncorps-k8s-local" {
  domain_name         = "${var.domain_name}"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster                         = "${var.Name}"
    Name                                      = "${var.Name}"
    "kubernetes.io/cluster/oncorps.k8s.local" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "oncorps-k8s-local" {
  vpc_id          = "${aws_vpc.oncorps-k8s-local.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.oncorps-k8s-local.id}"
}

terraform = {
  required_version = ">= 0.9.3"
}
