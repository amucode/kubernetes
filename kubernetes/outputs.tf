output "vpc_id" {
  value = "${aws_vpc.kukudkoo-k8s-local.id}"
}

output "utils_subnet_1a_id" {
  value = "${aws_subnet.utility-us-east-1a-kukudkoo-k8s-local.id}"
}

output "utils_subnet_1b_id" {
  value = "${aws_subnet.utility-us-east-1a-kukudkoo-k8s-local.id}"
}

output "utils_subnet_1c_id" {
  value = "${aws_subnet.utility-us-east-1c-kukudkoo-k8s-local.id}"
}

#############################MASTER SUBNET############################
output "master_subnet_1a_id" {
  value = "${aws_subnet.master-us-east-1a-kukudkoo-k8s-local.id}"
}

output "master_subnet_1b_id" {
  value = "${aws_subnet.master-us-east-1b-kukudkoo-k8s-local.id}"
}

output "master_subnet_1c_id" {
  value = "${aws_subnet.master-us-east-1c-kukudkoo-k8s-local.id}"
}

#############################NODE SUBNET############################

output "node_subnet_1a_id" {
  value = "${aws_subnet.node-us-east-1a-kukudkoo-k8s-local.id}"
}

output "node_subnet_1b_id" {
  value = "${aws_subnet.node-us-east-1b-kukudkoo-k8s-local.id}"
}

output "node_subnet_1c_id" {
  value = "${aws_subnet.node-us-east-1c-kukudkoo-k8s-local.id}"
}

#################################GATEWAYs ############################################

output "gateway_id" {
  value = "${aws_internet_gateway.kukudkoo-k8s-local.id}"
}

############################AWS KEY PAIR ######################################################

output "key_name" {
  value = "${aws_key_pair.kubernetes-kukudkoo-k8s-local-d02732f1485df0fa57c85e1ee6f06b63.key_name}"
}

################################### EIP ###################################

output "nat-1a-eip" {
  value = "${aws_eip.us-east-1a-kukudkoo-k8s-local.id}"
}

###################################Public ROUTE TABLE ############

output "public_route_table_id" {
  value = "${aws_route_table.public-kukudkoo-k8s-local.id}"
}

###################################Private ROUTE TABLE ############
output "private_route_table_id" {
  value = "${aws_route_table.private-kukudkoo-k8s-local.id}"
}

output "master-us-east-1a-route_table_association" {
  value = "${aws_route_table_association.master-us-east-1a-kukudkoo-k8s-local.id}"
}

output "master-us-east-1b-route_table_association" {
  value = "${aws_route_table_association.master-us-east-1b-kukudkoo-k8s-local.id}"
}

output "master-us-east-1c-route_table_association" {
  value = "${aws_route_table_association.master-us-east-1c-kukudkoo-k8s-local.id}"
}

output "node-us-east-1a-route_table_association" {
  value = "${aws_route_table_association.node-us-east-1a-kukudkoo-k8s-local.id}"
}

output "node-us-east-1b-route_table_association" {
  value = "${aws_route_table_association.node-us-east-1b-kukudkoo-k8s-local.id}"
}

output "node-us-east-1c-route_table_association" {
  value = "${aws_route_table_association.node-us-east-1c-kukudkoo-k8s-local.id}"
}

output "utils-us-east-1a-route_table_association" {
  value = "${aws_route_table_association.utils-us-east-1a-kukudkoo-k8s-local.id}"
}

output "utils-us-east-1b-route_table_association" {
  value = "${aws_route_table_association.utils-us-east-1b-kukudkoo-k8s-local.id}"
}

output "utils-us-east-1c-route_table_association" {
  value = "${aws_route_table_association.utils-us-east-1c-kukudkoo-k8s-local.id}"
}

#################################SEC Groups ###############################

output "api-lb-security-group-id" {
  value = "${aws_security_group.api-elb-kukudkoo-k8s-local.id}"
}

output "masters-security-group-id" {
  value = "${aws_security_group.api-elb-kukudkoo-k8s-local.id}"
}

output "nodes-security-group-id" {
  value = "${aws_security_group.api-elb-kukudkoo-k8s-local.id}"
}

output "jump-host-security-group-id" {
  value = "${aws_security_group.api-elb-kukudkoo-k8s-local.id}"
}

####################################JUMP-HOST 

output "jump-host-launch-configuration-id" {
  value = "${aws_launch_configuration.jump-host-kukudkoo-k8s-local.id}"
}

output "jump-host-autoscaling-group-id" {
  value = "${aws_autoscaling_group.jump-hosts-kukudkoo-k8s-local.id}"
}

###########################################Master Nodes 

output "master-1a-launch-configuration-id" {
  value = "${aws_launch_configuration.master-us-east-1a-masters-kukudkoo-k8s-local.id}"
}

output "master-1a-autoscaling-group-id" {
  value = "${aws_autoscaling_group.master-us-east-1a-masters-kukudkoo-k8s-local.id}"
}

output "master-1b-launch-configuration-id" {
  value = "${aws_launch_configuration.master-us-east-1b-masters-kukudkoo-k8s-local.id}"
}

output "master-1b-autoscaling-group-id" {
  value = "${aws_autoscaling_group.master-us-east-1b-masters-kukudkoo-k8s-local.id}"
}

output "master-1c-launch-configuration-id" {
  value = "${aws_launch_configuration.master-us-east-1c-masters-kukudkoo-k8s-local.id}"
}

output "master-1c-autoscaling-group-id" {
  value = "${aws_autoscaling_group.master-us-east-1c-masters-kukudkoo-k8s-local.id}"
}

##############Load Balacner Output################

output "api-lb-id" {
  value = "${aws_elb.api-kukudkoo-k8s-local.dns_name}"
}
