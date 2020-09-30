
output "vpc_id" {
  value = module.vpc.vpc_id.value
}

output "azs" {
  value = module.vpc.azs
}

output "private_subnets" {
  value = module.vpc.private_subnets.value
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets.value
}