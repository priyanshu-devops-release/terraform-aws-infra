resource "aws_vpc" "this" {
  // Name: aws_vpc.this
  // Purpose: Creates the main VPC
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    { Name = var.name },
    var.tags
  )
}

resource "aws_internet_gateway" "this" {
  // Name: aws_internet_gateway.this
  // Purpose: Attaches an Internet Gateway to the VPC for public internet access
  vpc_id = aws_vpc.this.id

  tags = merge(
    { Name = "${var.name}-igw" },
    var.tags
  )
}

resource "aws_subnet" "public_subnets" {
  // Name: aws_subnet.public
  // Purpose: Creates public subnets in the VPC
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = "${var.name}-public-${count.index + 1}"
      Tier = "public"
    },
    var.tags
  )
}

resource "aws_subnet" "private_subnets" {
  // Name: aws_subnet.private
  // Purpose: Creates private subnets in the VPC
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    {
      Name = "${var.name}-private-${count.index + 1}"
      Tier = "private"
    },
    var.tags
  )
}

resource "aws_eip" "nat" {
  // Name: aws_eip.nat
  // Purpose: Allocates an Elastic IP for the NAT Gateway
  count  = var.enable_nat_gateway ? 1 : 0

  tags = merge(
    { Name = "${var.name}-nat-eip" },
    var.tags
  )
}

resource "aws_nat_gateway" "this" {
  // Name: aws_nat_gateway.this
  // Purpose: Creates a NAT Gateway for outbound internet access from private subnets
  count         = var.enable_nat_gateway ? 1 : 0
  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = merge(
    { Name = "${var.name}-nat" },
    var.tags
  )

  depends_on = [aws_internet_gateway.this]
}

resource "aws_route_table" "public" {
  // Name: aws_route_table.public
  // Purpose: Route table for public subnets, routes traffic to the Internet Gateway
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(
    { Name = "${var.name}-public-rt" },
    var.tags
  )
}

resource "aws_route_table" "private" {
  // Name: aws_route_table.private
  // Purpose: Route table for private subnets, routes traffic to the NAT Gateway
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.enable_nat_gateway ? aws_nat_gateway.this[0].id : null
  }

  tags = merge(
    { Name = "${var.name}-private-rt" },
    var.tags
  )
}

resource "aws_route_table_association" "public_subnets" {
  // Name: aws_route_table_association.public
  // Purpose: Associates public subnets with the public route table
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_subnets.id
}

resource "aws_route_table_association" "private_subnets" {
  // Name: aws_route_table_association.private
  // Purpose: Associates private subnets with the private route table
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_subnets.id
}

