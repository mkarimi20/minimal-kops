locals = {
  cluster_name                      = "ops-work.net"
  master_autoscaling_group_ids      = ["${aws_autoscaling_group.master-eu-west-1a-masters-ops-work-net.id}"]
  master_security_group_ids         = ["${aws_security_group.masters-ops-work-net.id}"]
  masters_role_arn                  = "${aws_iam_role.masters-ops-work-net.arn}"
  masters_role_name                 = "${aws_iam_role.masters-ops-work-net.name}"
  node_autoscaling_group_ids        = ["${aws_autoscaling_group.nodes-ops-work-net.id}"]
  node_security_group_ids           = ["${aws_security_group.nodes-ops-work-net.id}"]
  node_subnet_ids                   = ["${aws_subnet.eu-west-1a-ops-work-net.id}", "${aws_subnet.eu-west-1b-ops-work-net.id}"]
  nodes_role_arn                    = "${aws_iam_role.nodes-ops-work-net.arn}"
  nodes_role_name                   = "${aws_iam_role.nodes-ops-work-net.name}"
  region                            = "eu-west-1"
  route_table_private-eu-west-1a_id = "${aws_route_table.private-eu-west-1a-ops-work-net.id}"
  route_table_private-eu-west-1b_id = "${aws_route_table.private-eu-west-1b-ops-work-net.id}"
  route_table_public_id             = "${aws_route_table.ops-work-net.id}"
  subnet_eu-west-1a_id              = "${aws_subnet.eu-west-1a-ops-work-net.id}"
  subnet_eu-west-1b_id              = "${aws_subnet.eu-west-1b-ops-work-net.id}"
  subnet_utility-eu-west-1a_id      = "${aws_subnet.utility-eu-west-1a-ops-work-net.id}"
  subnet_utility-eu-west-1b_id      = "${aws_subnet.utility-eu-west-1b-ops-work-net.id}"
  vpc_cidr_block                    = "${aws_vpc.ops-work-net.cidr_block}"
  vpc_id                            = "${aws_vpc.ops-work-net.id}"
}

output "cluster_name" {
  value = "ops-work.net"
}

output "master_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.master-eu-west-1a-masters-ops-work-net.id}"]
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-ops-work-net.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-ops-work-net.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-ops-work-net.name}"
}

output "node_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.nodes-ops-work-net.id}"]
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-ops-work-net.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.eu-west-1a-ops-work-net.id}", "${aws_subnet.eu-west-1b-ops-work-net.id}"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-ops-work-net.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-ops-work-net.name}"
}

output "region" {
  value = "eu-west-1"
}

output "route_table_private-eu-west-1a_id" {
  value = "${aws_route_table.private-eu-west-1a-ops-work-net.id}"
}

output "route_table_private-eu-west-1b_id" {
  value = "${aws_route_table.private-eu-west-1b-ops-work-net.id}"
}

output "route_table_public_id" {
  value = "${aws_route_table.ops-work-net.id}"
}

output "subnet_eu-west-1a_id" {
  value = "${aws_subnet.eu-west-1a-ops-work-net.id}"
}

output "subnet_eu-west-1b_id" {
  value = "${aws_subnet.eu-west-1b-ops-work-net.id}"
}

output "subnet_utility-eu-west-1a_id" {
  value = "${aws_subnet.utility-eu-west-1a-ops-work-net.id}"
}

output "subnet_utility-eu-west-1b_id" {
  value = "${aws_subnet.utility-eu-west-1b-ops-work-net.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.ops-work-net.cidr_block}"
}

output "vpc_id" {
  value = "${aws_vpc.ops-work-net.id}"
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_autoscaling_attachment" "master-eu-west-1a-masters-ops-work-net" {
  elb                    = "${aws_elb.api-ops-work-net.id}"
  autoscaling_group_name = "${aws_autoscaling_group.master-eu-west-1a-masters-ops-work-net.id}"
}

resource "aws_autoscaling_group" "master-eu-west-1a-masters-ops-work-net" {
  name                 = "master-eu-west-1a.masters.ops-work.net"
  launch_configuration = "${aws_launch_configuration.master-eu-west-1a-masters-ops-work-net.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.eu-west-1a-ops-work-net.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "ops-work.net"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-eu-west-1a.masters.ops-work.net"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-eu-west-1a"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  tag = {
    key                 = "kops.k8s.io/instancegroup"
    value               = "master-eu-west-1a"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-ops-work-net" {
  name                 = "nodes.ops-work.net"
  launch_configuration = "${aws_launch_configuration.nodes-ops-work-net.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.eu-west-1a-ops-work-net.id}", "${aws_subnet.eu-west-1b-ops-work-net.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "ops-work.net"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.ops-work.net"
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

  tag = {
    key                 = "kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "a-etcd-events-ops-work-net" {
  availability_zone = "eu-west-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                    = "ops-work.net"
    Name                                 = "a.etcd-events.ops-work.net"
    "k8s.io/etcd/events"                 = "a/a"
    "k8s.io/role/master"                 = "1"
    "kubernetes.io/cluster/ops-work.net" = "owned"
  }
}

resource "aws_ebs_volume" "a-etcd-main-ops-work-net" {
  availability_zone = "eu-west-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                    = "ops-work.net"
    Name                                 = "a.etcd-main.ops-work.net"
    "k8s.io/etcd/main"                   = "a/a"
    "k8s.io/role/master"                 = "1"
    "kubernetes.io/cluster/ops-work.net" = "owned"
  }
}

resource "aws_eip" "eu-west-1a-ops-work-net" {
  vpc = true

  tags = {
    KubernetesCluster                    = "ops-work.net"
    Name                                 = "eu-west-1a.ops-work.net"
    "kubernetes.io/cluster/ops-work.net" = "owned"
  }
}

resource "aws_eip" "eu-west-1b-ops-work-net" {
  vpc = true

  tags = {
    KubernetesCluster                    = "ops-work.net"
    Name                                 = "eu-west-1b.ops-work.net"
    "kubernetes.io/cluster/ops-work.net" = "owned"
  }
}

resource "aws_elb" "api-ops-work-net" {
  name = "api-ops-work-net-e43b2n"

  listener = {
    instance_port     = 443
    instance_protocol = "TCP"
    lb_port           = 443
    lb_protocol       = "TCP"
  }

  security_groups = ["${aws_security_group.api-elb-ops-work-net.id}"]
  subnets         = ["${aws_subnet.utility-eu-west-1a-ops-work-net.id}", "${aws_subnet.utility-eu-west-1b-ops-work-net.id}"]

  health_check = {
    target              = "SSL:443"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    timeout             = 5
  }

  cross_zone_load_balancing = false
  idle_timeout              = 300

  tags = {
    KubernetesCluster                    = "ops-work.net"
    Name                                 = "api.ops-work.net"
    "kubernetes.io/cluster/ops-work.net" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-ops-work-net" {
  name = "masters.ops-work.net"
  role = "${aws_iam_role.masters-ops-work-net.name}"
}

resource "aws_iam_instance_profile" "nodes-ops-work-net" {
  name = "nodes.ops-work.net"
  role = "${aws_iam_role.nodes-ops-work-net.name}"
}

resource "aws_iam_role" "masters-ops-work-net" {
  name               = "masters.ops-work.net"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.ops-work.net_policy")}"
}

resource "aws_iam_role" "nodes-ops-work-net" {
  name               = "nodes.ops-work.net"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.ops-work.net_policy")}"
}

resource "aws_iam_role_policy" "masters-ops-work-net" {
  name   = "masters.ops-work.net"
  role   = "${aws_iam_role.masters-ops-work-net.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.ops-work.net_policy")}"
}

resource "aws_iam_role_policy" "nodes-ops-work-net" {
  name   = "nodes.ops-work.net"
  role   = "${aws_iam_role.nodes-ops-work-net.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.ops-work.net_policy")}"
}

resource "aws_internet_gateway" "ops-work-net" {
  vpc_id = "${aws_vpc.ops-work-net.id}"

  tags = {
    KubernetesCluster                    = "ops-work.net"
    Name                                 = "ops-work.net"
    "kubernetes.io/cluster/ops-work.net" = "owned"
  }
}

resource "aws_key_pair" "kubernetes-ops-work-net-fd6ecb49ccf2204d8ef4a372199dc185" {
  key_name   = "kubernetes.ops-work.net-fd:6e:cb:49:cc:f2:20:4d:8e:f4:a3:72:19:9d:c1:85"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.ops-work.net-fd6ecb49ccf2204d8ef4a372199dc185_public_key")}"
}

resource "aws_launch_configuration" "master-eu-west-1a-masters-ops-work-net" {
  name_prefix                 = "master-eu-west-1a.masters.ops-work.net-"
  image_id                    = "ami-09e51e3726d58e07a"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-ops-work-net-fd6ecb49ccf2204d8ef4a372199dc185.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-ops-work-net.id}"
  security_groups             = ["${aws_security_group.masters-ops-work-net.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-eu-west-1a.masters.ops-work.net_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-ops-work-net" {
  name_prefix                 = "nodes.ops-work.net-"
  image_id                    = "ami-09e51e3726d58e07a"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-ops-work-net-fd6ecb49ccf2204d8ef4a372199dc185.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-ops-work-net.id}"
  security_groups             = ["${aws_security_group.nodes-ops-work-net.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.ops-work.net_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_nat_gateway" "eu-west-1a-ops-work-net" {
  allocation_id = "${aws_eip.eu-west-1a-ops-work-net.id}"
  subnet_id     = "${aws_subnet.utility-eu-west-1a-ops-work-net.id}"

  tags = {
    KubernetesCluster                    = "ops-work.net"
    Name                                 = "eu-west-1a.ops-work.net"
    "kubernetes.io/cluster/ops-work.net" = "owned"
  }
}

resource "aws_nat_gateway" "eu-west-1b-ops-work-net" {
  allocation_id = "${aws_eip.eu-west-1b-ops-work-net.id}"
  subnet_id     = "${aws_subnet.utility-eu-west-1b-ops-work-net.id}"

  tags = {
    KubernetesCluster                    = "ops-work.net"
    Name                                 = "eu-west-1b.ops-work.net"
    "kubernetes.io/cluster/ops-work.net" = "owned"
  }
}

resource "aws_route" "route-0-0-0-0--0" {
  route_table_id         = "${aws_route_table.ops-work-net.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.ops-work-net.id}"
}

resource "aws_route" "route-private-eu-west-1a-0-0-0-0--0" {
  route_table_id         = "${aws_route_table.private-eu-west-1a-ops-work-net.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.eu-west-1a-ops-work-net.id}"
}

resource "aws_route" "route-private-eu-west-1b-0-0-0-0--0" {
  route_table_id         = "${aws_route_table.private-eu-west-1b-ops-work-net.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.eu-west-1b-ops-work-net.id}"
}

resource "aws_route53_record" "api-ops-work-net" {
  name = "api.ops-work.net"
  type = "A"

  alias = {
    name                   = "${aws_elb.api-ops-work-net.dns_name}"
    zone_id                = "${aws_elb.api-ops-work-net.zone_id}"
    evaluate_target_health = false
  }

  zone_id = "/hostedzone/ZU8YL4QP2WY4L"
}

resource "aws_route_table" "ops-work-net" {
  vpc_id = "${aws_vpc.ops-work-net.id}"

  tags = {
    KubernetesCluster                    = "ops-work.net"
    Name                                 = "ops-work.net"
    "kubernetes.io/cluster/ops-work.net" = "owned"
    "kubernetes.io/kops/role"            = "public"
  }
}

resource "aws_route_table" "private-eu-west-1a-ops-work-net" {
  vpc_id = "${aws_vpc.ops-work-net.id}"

  tags = {
    KubernetesCluster                    = "ops-work.net"
    Name                                 = "private-eu-west-1a.ops-work.net"
    "kubernetes.io/cluster/ops-work.net" = "owned"
    "kubernetes.io/kops/role"            = "private-eu-west-1a"
  }
}

resource "aws_route_table" "private-eu-west-1b-ops-work-net" {
  vpc_id = "${aws_vpc.ops-work-net.id}"

  tags = {
    KubernetesCluster                    = "ops-work.net"
    Name                                 = "private-eu-west-1b.ops-work.net"
    "kubernetes.io/cluster/ops-work.net" = "owned"
    "kubernetes.io/kops/role"            = "private-eu-west-1b"
  }
}

resource "aws_route_table_association" "private-eu-west-1a-ops-work-net" {
  subnet_id      = "${aws_subnet.eu-west-1a-ops-work-net.id}"
  route_table_id = "${aws_route_table.private-eu-west-1a-ops-work-net.id}"
}

resource "aws_route_table_association" "private-eu-west-1b-ops-work-net" {
  subnet_id      = "${aws_subnet.eu-west-1b-ops-work-net.id}"
  route_table_id = "${aws_route_table.private-eu-west-1b-ops-work-net.id}"
}

resource "aws_route_table_association" "utility-eu-west-1a-ops-work-net" {
  subnet_id      = "${aws_subnet.utility-eu-west-1a-ops-work-net.id}"
  route_table_id = "${aws_route_table.ops-work-net.id}"
}

resource "aws_route_table_association" "utility-eu-west-1b-ops-work-net" {
  subnet_id      = "${aws_subnet.utility-eu-west-1b-ops-work-net.id}"
  route_table_id = "${aws_route_table.ops-work-net.id}"
}

resource "aws_security_group" "api-elb-ops-work-net" {
  name        = "api-elb.ops-work.net"
  vpc_id      = "${aws_vpc.ops-work-net.id}"
  description = "Security group for api ELB"

  tags = {
    KubernetesCluster                    = "ops-work.net"
    Name                                 = "api-elb.ops-work.net"
    "kubernetes.io/cluster/ops-work.net" = "owned"
  }
}

resource "aws_security_group" "masters-ops-work-net" {
  name        = "masters.ops-work.net"
  vpc_id      = "${aws_vpc.ops-work-net.id}"
  description = "Security group for masters"

  tags = {
    KubernetesCluster                    = "ops-work.net"
    Name                                 = "masters.ops-work.net"
    "kubernetes.io/cluster/ops-work.net" = "owned"
  }
}

resource "aws_security_group" "nodes-ops-work-net" {
  name        = "nodes.ops-work.net"
  vpc_id      = "${aws_vpc.ops-work-net.id}"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                    = "ops-work.net"
    Name                                 = "nodes.ops-work.net"
    "kubernetes.io/cluster/ops-work.net" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-ops-work-net.id}"
  source_security_group_id = "${aws_security_group.masters-ops-work-net.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-ops-work-net.id}"
  source_security_group_id = "${aws_security_group.masters-ops-work-net.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-ops-work-net.id}"
  source_security_group_id = "${aws_security_group.nodes-ops-work-net.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "api-elb-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.api-elb-ops-work-net.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https-api-elb-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.api-elb-ops-work-net.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https-elb-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-ops-work-net.id}"
  source_security_group_id = "${aws_security_group.api-elb-ops-work-net.id}"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "icmp-pmtu-api-elb-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.api-elb-ops-work-net.id}"
  from_port         = 3
  to_port           = 4
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-ops-work-net.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-ops-work-net.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-ops-work-net.id}"
  source_security_group_id = "${aws_security_group.nodes-ops-work-net.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-ops-work-net.id}"
  source_security_group_id = "${aws_security_group.nodes-ops-work-net.id}"
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-ops-work-net.id}"
  source_security_group_id = "${aws_security_group.nodes-ops-work-net.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-ops-work-net.id}"
  source_security_group_id = "${aws_security_group.nodes-ops-work-net.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-ops-work-net.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.nodes-ops-work-net.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "eu-west-1a-ops-work-net" {
  vpc_id            = "${aws_vpc.ops-work-net.id}"
  cidr_block        = "172.20.32.0/19"
  availability_zone = "eu-west-1a"

  tags = {
    KubernetesCluster                    = "ops-work.net"
    Name                                 = "eu-west-1a.ops-work.net"
    SubnetType                           = "Private"
    "kubernetes.io/cluster/ops-work.net" = "owned"
    "kubernetes.io/role/internal-elb"    = "1"
  }
}

resource "aws_subnet" "eu-west-1b-ops-work-net" {
  vpc_id            = "${aws_vpc.ops-work-net.id}"
  cidr_block        = "172.20.64.0/19"
  availability_zone = "eu-west-1b"

  tags = {
    KubernetesCluster                    = "ops-work.net"
    Name                                 = "eu-west-1b.ops-work.net"
    SubnetType                           = "Private"
    "kubernetes.io/cluster/ops-work.net" = "owned"
    "kubernetes.io/role/internal-elb"    = "1"
  }
}

resource "aws_subnet" "utility-eu-west-1a-ops-work-net" {
  vpc_id            = "${aws_vpc.ops-work-net.id}"
  cidr_block        = "172.20.0.0/22"
  availability_zone = "eu-west-1a"

  tags = {
    KubernetesCluster                    = "ops-work.net"
    Name                                 = "utility-eu-west-1a.ops-work.net"
    SubnetType                           = "Utility"
    "kubernetes.io/cluster/ops-work.net" = "owned"
    "kubernetes.io/role/elb"             = "1"
  }
}

resource "aws_subnet" "utility-eu-west-1b-ops-work-net" {
  vpc_id            = "${aws_vpc.ops-work-net.id}"
  cidr_block        = "172.20.4.0/22"
  availability_zone = "eu-west-1b"

  tags = {
    KubernetesCluster                    = "ops-work.net"
    Name                                 = "utility-eu-west-1b.ops-work.net"
    SubnetType                           = "Utility"
    "kubernetes.io/cluster/ops-work.net" = "owned"
    "kubernetes.io/role/elb"             = "1"
  }
}

resource "aws_vpc" "ops-work-net" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster                    = "ops-work.net"
    Name                                 = "ops-work.net"
    "kubernetes.io/cluster/ops-work.net" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "ops-work-net" {
  domain_name         = "eu-west-1.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster                    = "ops-work.net"
    Name                                 = "ops-work.net"
    "kubernetes.io/cluster/ops-work.net" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "ops-work-net" {
  vpc_id          = "${aws_vpc.ops-work-net.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.ops-work-net.id}"
}

terraform = {
  required_version = ">= 0.9.3"
}
