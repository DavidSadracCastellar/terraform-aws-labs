##################
# vpc
##################
resource "aws_vpc" "this" {
  cidr_block        = var.cidr
  instance_tenancy  = var.instance_tenancy

  tags = merge(
    {
      Name = "${var.project_name}-vpc"
    },
    var.vpc_tags
  )
}

##################
# Public Subnet
##################
resource "aws_subnet" "public" {
  vpc_id               = aws_vpc.this.id
  cidr_block           = var.vpc_subnets[0]
  availability_zone    = element(var.azs, 0)
  #availability_zone_id = element(var.azs, 0)

  tags = {
      Name = "${var.project_name}-public-subnet"
  }
}

##################
# Private Subnet
##################
resource "aws_subnet" "private" {
  vpc_id               = aws_vpc.this.id
  cidr_block           = var.vpc_subnets[1]
  availability_zone    = element(var.azs, 0)
  #availability_zone_id = element(var.azs, 0)

  tags = {
      Name = "${var.project_name}-private-subnet"
  }
}

##################
# Protected Subnet
##################
resource "aws_subnet" "protected" {
  vpc_id               = aws_vpc.this.id
  cidr_block           = var.vpc_subnets[2]
  availability_zone    = element(var.azs, 0)
  #availability_zone_id = element(var.azs, 1)

  tags = {
      Name = "${var.project_name}-protected-subnet"
  }
}

#####################
# Public ACLs
#####################
resource "aws_network_acl" "public" {
  vpc_id     = aws_vpc.this.id
  subnet_ids = [aws_subnet.public.id]

  tags = {
    Name = "${var.project_name}-acl-public"
  }
}

resource "aws_network_acl_rule" "inbound_public_one" {
  network_acl_id = aws_network_acl.public.id

  egress          = false
  rule_number     = var.public_inbound_acl_rules[0]["rule_number"]
  rule_action     = var.public_inbound_acl_rules[0]["rule_action"]
  from_port       = lookup(var.public_inbound_acl_rules[0], "from_port", null)
  to_port         = lookup(var.public_inbound_acl_rules[0], "to_port", null)
  icmp_code       = lookup(var.public_inbound_acl_rules[0], "icmp_code", null)
  icmp_type       = lookup(var.public_inbound_acl_rules[0], "icmp_type", null)
  protocol        = var.public_inbound_acl_rules[0]["protocol"]
  cidr_block      = lookup(var.public_inbound_acl_rules[0], "cidr_block", null)
}

resource "aws_network_acl_rule" "inbound_public_two" {
  network_acl_id = aws_network_acl.public.id

  egress          = false
  rule_number     = var.public_inbound_acl_rules[1]["rule_number"]
  rule_action     = var.public_inbound_acl_rules[1]["rule_action"]
  from_port       = lookup(var.public_inbound_acl_rules[1], "from_port", null)
  to_port         = lookup(var.public_inbound_acl_rules[1], "to_port", null)
  icmp_code       = lookup(var.public_inbound_acl_rules[1], "icmp_code", null)
  icmp_type       = lookup(var.public_inbound_acl_rules[1], "icmp_type", null)
  protocol        = var.public_inbound_acl_rules[1]["protocol"]
  cidr_block      = lookup(var.public_inbound_acl_rules[1], "cidr_block", null)
}

resource "aws_network_acl_rule" "inbound_public_three" {
  network_acl_id = aws_network_acl.public.id

  egress          = false
  rule_number     = var.public_inbound_acl_rules[2]["rule_number"]
  rule_action     = var.public_inbound_acl_rules[2]["rule_action"]
  from_port       = lookup(var.public_inbound_acl_rules[2], "from_port", null)
  to_port         = lookup(var.public_inbound_acl_rules[2], "to_port", null)
  icmp_code       = lookup(var.public_inbound_acl_rules[2], "icmp_code", null)
  icmp_type       = lookup(var.public_inbound_acl_rules[2], "icmp_type", null)
  protocol        = var.public_inbound_acl_rules[2]["protocol"]
  cidr_block      = lookup(var.public_inbound_acl_rules[2], "cidr_block", null)
}

resource "aws_network_acl_rule" "outbound_public" {
  network_acl_id = aws_network_acl.public.id

  egress          = true
  rule_number     = var.public_outbound_acl_rules[0]["rule_number"]
  rule_action     = var.public_outbound_acl_rules[0]["rule_action"]
  from_port       = lookup(var.public_outbound_acl_rules[0], "from_port", null)
  to_port         = lookup(var.public_outbound_acl_rules[0], "to_port", null)
  icmp_code       = lookup(var.public_outbound_acl_rules[0], "icmp_code", null)
  icmp_type       = lookup(var.public_outbound_acl_rules[0], "icmp_type", null)
  protocol        = var.public_outbound_acl_rules[0]["protocol"]
  cidr_block      = lookup(var.public_outbound_acl_rules[0], "cidr_block", null)
}

#####################
# Private ACLs
#####################
resource "aws_network_acl" "private" {
  vpc_id     = aws_vpc.this.id
  subnet_ids = [aws_subnet.private.id]

  tags = {
    Name = "${var.project_name}-acl-private"
  }
}

resource "aws_network_acl_rule" "inbound_private_one" {
  network_acl_id = aws_network_acl.private.id

  egress          = false
  rule_number     = var.private_inbound_acl_rules[0]["rule_number"]
  rule_action     = var.private_inbound_acl_rules[0]["rule_action"]
  from_port       = lookup(var.private_inbound_acl_rules[0], "from_port", null)
  to_port         = lookup(var.private_inbound_acl_rules[0], "to_port", null)
  icmp_code       = lookup(var.private_inbound_acl_rules[0], "icmp_code", null)
  icmp_type       = lookup(var.private_inbound_acl_rules[0], "icmp_type", null)
  protocol        = var.private_inbound_acl_rules[0]["protocol"]
  cidr_block      = lookup(var.private_inbound_acl_rules[0], "cidr_block", null)
}

resource "aws_network_acl_rule" "inbound_private_two" {
  network_acl_id = aws_network_acl.private.id

  egress          = false
  rule_number     = var.private_inbound_acl_rules[1]["rule_number"]
  rule_action     = var.private_inbound_acl_rules[1]["rule_action"]
  from_port       = lookup(var.private_inbound_acl_rules[1], "from_port", null)
  to_port         = lookup(var.private_inbound_acl_rules[1], "to_port", null)
  icmp_code       = lookup(var.private_inbound_acl_rules[1], "icmp_code", null)
  icmp_type       = lookup(var.private_inbound_acl_rules[1], "icmp_type", null)
  protocol        = var.private_inbound_acl_rules[1]["protocol"]
  cidr_block      = lookup(var.private_inbound_acl_rules[1], "cidr_block", null)
}

resource "aws_network_acl_rule" "inbound_private_three" {
  network_acl_id = aws_network_acl.private.id

  egress          = false
  rule_number     = var.private_inbound_acl_rules[2]["rule_number"]
  rule_action     = var.private_inbound_acl_rules[2]["rule_action"]
  from_port       = lookup(var.private_inbound_acl_rules[2], "from_port", null)
  to_port         = lookup(var.private_inbound_acl_rules[2], "to_port", null)
  icmp_code       = lookup(var.private_inbound_acl_rules[2], "icmp_code", null)
  icmp_type       = lookup(var.private_inbound_acl_rules[2], "icmp_type", null)
  protocol        = var.private_inbound_acl_rules[2]["protocol"]
  cidr_block      = lookup(var.private_inbound_acl_rules[2], "cidr_block", null)
}

resource "aws_network_acl_rule" "outbound_private" {
  network_acl_id = aws_network_acl.private.id

  egress          = true
  rule_number     = var.private_outbound_acl_rules[0]["rule_number"]
  rule_action     = var.private_outbound_acl_rules[0]["rule_action"]
  from_port       = lookup(var.private_outbound_acl_rules[0], "from_port", null)
  to_port         = lookup(var.private_outbound_acl_rules[0], "to_port", null)
  icmp_code       = lookup(var.private_outbound_acl_rules[0], "icmp_code", null)
  icmp_type       = lookup(var.private_outbound_acl_rules[0], "icmp_type", null)
  protocol        = var.private_outbound_acl_rules[0]["protocol"]
  cidr_block      = lookup(var.private_outbound_acl_rules[0], "cidr_block", null)
}

#####################
# Protected ACLs
#####################
resource "aws_network_acl" "protected" {
  vpc_id     = aws_vpc.this.id
  subnet_ids = [aws_subnet.protected.id]

  tags = {
    Name = "${var.project_name}-protected-acl"
  }
}

resource "aws_network_acl_rule" "inbound_protected" {
  network_acl_id = aws_network_acl.protected.id

  egress          = false
  rule_number     = var.protected_inbound_acl_rules[0]["rule_number"]
  rule_action     = var.protected_inbound_acl_rules[0]["rule_action"]
  from_port       = lookup(var.protected_inbound_acl_rules[0], "from_port", null)
  to_port         = lookup(var.protected_inbound_acl_rules[0], "to_port", null)
  icmp_code       = lookup(var.protected_inbound_acl_rules[0], "icmp_code", null)
  icmp_type       = lookup(var.protected_inbound_acl_rules[0], "icmp_type", null)
  protocol        = var.protected_inbound_acl_rules[0]["protocol"]
  cidr_block      = lookup(var.protected_inbound_acl_rules[0], "cidr_block", null)
}

resource "aws_network_acl_rule" "outbound_protected" {
  network_acl_id = aws_network_acl.protected.id

  egress          = true
  rule_number     = var.protected_outbound_acl_rules[0]["rule_number"]
  rule_action     = var.protected_outbound_acl_rules[0]["rule_action"]
  from_port       = lookup(var.protected_outbound_acl_rules[0], "from_port", null)
  to_port         = lookup(var.protected_outbound_acl_rules[0], "to_port", null)
  icmp_code       = lookup(var.protected_outbound_acl_rules[0], "icmp_code", null)
  icmp_type       = lookup(var.protected_outbound_acl_rules[0], "icmp_type", null)
  protocol        = var.protected_outbound_acl_rules[0]["protocol"]
  cidr_block      = lookup(var.protected_outbound_acl_rules[0], "cidr_block", null)
}

#######################
# Internet Gateway 
#######################
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-gw"
  }
}

###################
# Eip
###################
resource "aws_eip" "this" {
  vpc = true
}

###################
# Nat Gateway
###################
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.private.id

  tags = {
    Name = "${var.project_name}-gw-NAT"
  }
}

################
# Publiс Route
################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id

  timeouts {
    create = "5m"
  }
}

################
# Private Route
################
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-private-rt"
  }
}

resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "10.0.0.0/16"
  nat_gateway_id         = aws_nat_gateway.this.id

  timeouts {
    create = "5m"
  }
}

################
# Protected Route
################
resource "aws_route_table" "protected" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-protected-rt"
  }
}

##########################
# Route table association
##########################
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "protected" {
  subnet_id      = aws_subnet.protected.id
  route_table_id = aws_route_table.protected.id
}

#######################
# Security Groups
#######################
resource "aws_security_group" "allow_ssh_anywhere" {
  name        = "${var.project_name}-allow_ssh_anywhere"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-allow_ssh"
  }
}

resource "aws_security_group" "allow_http_anywhere" {
  name        = "${var.project_name}-allow_http_anywhere"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-allow_http"
  }
}

############################
# ELB
############################
/**
resource "aws_elb" "web" {
  name               = "${var.project_name}-elb"
  subnets            = aws_subnet.public.*.id

  security_groups = [
    aws_security_group.allow_http_anywhere.id
  ]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 2
    target              = "HTTP:80/"
    interval            = 10
  }

  tags = {
    Name = "${var.project_name}-web-elb"
  }
}
*/