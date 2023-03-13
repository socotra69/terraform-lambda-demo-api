
module "repositories" {
  source   = "../modules/ecr"
  name = "demoapi"
  tags = local.tags
}
