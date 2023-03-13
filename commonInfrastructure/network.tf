resource "aws_vpc_dhcp_options" "main" {
  domain_name_servers = ["AmazonProvidedDNS"]
  domain_name         = "${data.aws_region.current.name}.compute.internal"

  tags = merge(local.tags, {
    Name     = "${local.company}-${var.env}-dhcp-01"
    function = "network"
  })
}

module "vpcMain" {
  source = "../modules/vpc"

  vpc_cidr = var.vpc_cidr
  zones    = var.zones

  dhcp            = aws_vpc_dhcp_options.main.id
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  company = local.company
  env     = var.env

  tags = merge(local.tags, {
  function = "network" })

}
