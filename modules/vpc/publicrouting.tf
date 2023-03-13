

## public route tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge({
    Name = "${var.company}-${var.env}-rtt-public-${var.index}"
  }, var.tags)
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge({
    Name = "${var.company}-${var.env}-igw-${var.index}"
  }, var.tags)
}

resource "aws_route" "public-default" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}


