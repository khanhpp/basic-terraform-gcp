module "vpc" {
  source       = "./modules/vpc"
  project_id   = data.google_project.project_dev_tiki_infra.project_id
  network_name = var.network_name
}

module "subnets" {
  source                = "./modules/subnetwork"
  project_id            = data.google_project.project_dev_tiki_infra.project_id
  public_subnet_region  = var.public_subnet_region
  network_name          = module.vpc.network_name
  public_subnet_name    = var.public_subnet_name
  public_subnet_cidr    = var.public_subnet_cidr
}

module "webapp" {
  source                = "./modules/webapp"
  project_id            = data.google_project.project_dev_tiki_infra.project_id
  region                = var.public_subnet_region
  network_name          = module.vpc.network_name
  subnetwork_name       = var.public_subnet_name
}
