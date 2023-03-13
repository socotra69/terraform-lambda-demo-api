## create eip and nat
resource "aws_eip" "nat" {
  vpc = true

  tags = merge({
    Name = "${var.company}-${var.env}-eip-nat-${var.index}"
  }, var.tags)
}

resource "aws_nat_gateway" "main" {
  allocation_id     = aws_eip.nat.id
  subnet_id         = aws_subnet.public[0].id
  connectivity_type = "public"

  tags = merge({
    Name = "${var.company}-${var.env}-nat-${var.index}"
  }, var.tags)
}

## create private routing
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  tags = merge({
    Name = "${var.company}-${var.env}-rtt--private-${var.index}"
  }, var.tags)
}

resource "aws_route" "private-default" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

