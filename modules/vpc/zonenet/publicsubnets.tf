resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  vpc_id            = var.vpc_id
  availability_zone = var.zone

  cidr_block              = var.public_subnets[count.index].cidr
  map_public_ip_on_launch = var.autopublic_ip

  tags = merge({
    Name = "${var.company}-${var.env}-subnet-${var.public_subnets[count.index].label}-public-${var.index + count.index}"
    Tier = "Public"
    },
  var.tags)
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = var.publicrtt_id
}

