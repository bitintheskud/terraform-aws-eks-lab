
output "vpc_id" {
  value = concat(module.vpc.vpc_id.value, [""])[0]
}

output "azs" {
  value = module.vpc.azs
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
}