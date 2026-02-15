resource "aws_vpc" "this" {
  count                  = var.create_vpc ? 1 : 0
  cidr_block             = var.vpc_cidr
  enable_dns_hostnames   = true

  tags = merge(
    {
      Name = "${var.tags["Environment"]}-vpc"
    },
    var.tags
  )
}

resource "aws_internet_gateway" "igw" {
  count = var.create_vpc ? 1 : 0
  vpc_id = aws_vpc.this[0].id

  tags = var.tags
}

resource "aws_subnet" "public" {
  count = var.create_vpc ? length(var.public_subnet_cidrs) : 0
  vpc_id                  = aws_vpc.this[0].id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = "${var.tags["Environment"]}-public-${count.index}"
    },
    var.tags
  )
}

resource "aws_subnet" "private" {
  count             = var.create_vpc ? length(var.private_subnet_cidrs) : 0
  vpc_id            = aws_vpc.this[0].id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(
    {
      Name = "${var.tags["Environment"]}-private-${count.index}"
    },
    var.tags
  )
}

resource "aws_route_table" "public" {
  count = var.create_vpc ? 1 : 0
  vpc_id = aws_vpc.this[0].id
  tags   = var.tags
}

resource "aws_route" "internet" {
  count                   = var.create_vpc ? 1 : 0
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw[0].id
}

resource "aws_route_table_association" "public_assoc" {
  count          = var.create_vpc ? length(aws_subnet.public) : 0
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[0].id
}

resource "aws_route_table" "private" {
  count = var.create_vpc ? 1 : 0
  vpc_id = aws_vpc.this[0].id
  tags   = var.tags
}

resource "aws_route_table_association" "private_assoc" {
  count          = var.create_vpc ? length(aws_subnet.private) : 0
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[0].id
}