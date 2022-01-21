##################
# vpc
##################
resource "aws_vpc" "this" {
  cidr_block        = var.cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = merge(
    {
      Name = "${var.project_name}-${var.environment}-vpc"
    },
    var.vpc_tags
  )
}

#######################
# Internet Gateway 
#######################
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-${var.environment}-gw"
  }
}

######################
# Add dchp options
######################
resource "aws_vpc_dhcp_options" "dns_resolve" {
  domain_name_servers = ["8.8.8.8","8.8.4.4"]
}

resource "aws_vpc_dhcp_options_association" "dns_resolve" {
  vpc_id          = aws_vpc.this.id
  dhcp_options_id = aws_vpc_dhcp_options.dns_resolve.id
}

##################
# Public Subnets
##################
resource "aws_subnet" "public_one" {
  vpc_id               = aws_vpc.this.id
  cidr_block           = var.vpc_subnets_public[0]
  availability_zone    = element(var.azs, 0)

  tags = {
      Name = "${var.project_name}-${var.environment}-one-public-subnet"
  }
  depends_on = [aws_vpc_dhcp_options_association.dns_resolve]
}

resource "aws_subnet" "public_two" {
  vpc_id               = aws_vpc.this.id
  cidr_block           = var.vpc_subnets_public[1]
  availability_zone    = element(var.azs, 1)

  tags = {
      Name = "${var.project_name}-${var.environment}-two-public-subnet"
  }
  depends_on = [aws_vpc_dhcp_options_association.dns_resolve]
}

##################
# Private Subnets
##################
resource "aws_subnet" "private_one" {
  vpc_id               = aws_vpc.this.id
  cidr_block           = var.vpc_subnets_private[0]
  availability_zone    = element(var.azs, 0)

  tags = {
      Name = "${var.project_name}-${var.environment}-one-private-subnet"
  }
  depends_on = [aws_vpc_dhcp_options_association.dns_resolve]
}

resource "aws_subnet" "private_two" {
  vpc_id               = aws_vpc.this.id
  cidr_block           = var.vpc_subnets_private[1]
  availability_zone    = element(var.azs, 1)

  tags = {
      Name = "${var.project_name}-${var.environment}-two-private-subnet"
  }
  depends_on = [aws_vpc_dhcp_options_association.dns_resolve]
}

#####################
# Public ACLs
#####################
resource "aws_network_acl" "public" {
  vpc_id     = aws_vpc.this.id
  subnet_ids = [aws_subnet.public_one.id, aws_subnet.public_two.id]

  tags = {
    Name = "${var.project_name}-${var.environment}-acl-public"
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
  subnet_ids = [aws_subnet.private_one.id, aws_subnet.private_two.id]

  tags = {
    Name = "${var.project_name}-${var.environment}-acl-private"
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

###################
# Eip
###################
resource "aws_eip" "this" {
  vpc = true
  depends_on = [aws_internet_gateway.this]
}

###################
# Nat Gateway
###################
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.public_one.id

  tags = {
    Name = "${var.project_name}-${var.environment}-gw-NAT"
  }
}

################
# Publiс Route
################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-${var.environment}-public-rt"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id

}

################
# Private Route
################
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-${var.environment}-private-rt"
  }
}

resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id
}

##########################
# Route table association
##########################
resource "aws_route_table_association" "public_one" {
  subnet_id      = aws_subnet.public_one.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_two" {
  subnet_id      = aws_subnet.public_two.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_one" {
  subnet_id      = aws_subnet.private_one.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_two" {
  subnet_id      = aws_subnet.private_two.id
  route_table_id = aws_route_table.private.id
}

#######################
# Security Groups
#######################
resource "aws_security_group" "public_ssh_anywhere" {
    name        = "${var.project_name}-public_ssh_anywhere"
    description = "Allow SSH inbound traffic from public"
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
        Name = "${var.project_name}-${var.environment}-public-allow_ssh"
    }
}

resource "aws_security_group" "private_ssh_anywhere" {
    name        = "${var.project_name}-private-allow_ssh_anywhere"
    description = "Allow SSH inbound traffic inter private"
    vpc_id      = aws_vpc.this.id

    ingress {
        description = "SSH from VPC"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = var.vpc_subnets_private
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = var.vpc_subnets_private
    }

    tags = {
        Name = "${var.project_name}-${var.environment}-private-allow_ssh"
    }
}

resource "aws_security_group" "public_http_anywhere" {
    name        = "${var.project_name}-public-allow_http_anywhere"
    description = "Allow HTTP inbound traffic in group public"
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
        Name = "${var.project_name}-${var.environment}-public-allow_http"
    }
}

resource "aws_security_group" "private_http_anywhere" {
    name        = "${var.project_name}-private-allow_http_anywhere"
    description = "Allows ALB to access the EC2 instances"
    vpc_id      = aws_vpc.this.id

    ingress {
        description = "HTTP from VPC"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = var.vpc_subnets_private
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = var.vpc_subnets_private
    }

    tags = {
        Name = "${var.project_name}-${var.environment}-private-allow_http"
    }
}

