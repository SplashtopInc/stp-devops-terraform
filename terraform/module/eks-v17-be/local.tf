locals {
  be_userdata_template_file = var.be_eks_bottlerocket_enabled ? "./userdata.toml" : ".terraform/modules/eks-be/templates/userdata.sh.tpl"
  worker_ami_owner_id       = var.be_eks_bottlerocket_enabled ? var.bottlerocket_worker_ami_owner_id : var.hardened_worker_ami_owner_id
  worker_ami_linux          = var.be_eks_bottlerocket_enabled ? data.aws_ami.bottlerocket_ami.id : var.hardened_worker_ami_linux

  # substr(string, offset, length)
  cluster_name_project = lower(var.project)
  cluster_name_region  = join("", [substr(replace(var.region, "-", ""), 0, 3), regex("\\d$", var.region)])
  cluster_name_env     = substr(var.environment, 0, 4)

  cluster_name_suffix = "${local.cluster_name_env}-${local.cluster_name_region}-${random_string.suffix.result}"


  # cluster name 
  bottlerocket_cluster_name = "${local.cluster_name_project}-${local.cluster_name_suffix}"

  app_short_name          = replace(var.app_service, "-", "")
  mymail_short_name       = replace(var.mymail_service, "-", "")
  cloudbuild_short_name   = replace(var.cloudbuild_service, "-", "")
  relayfe_short_name      = replace(var.relayfe_service, "-", "")
  relayrs_short_name      = replace(var.relayrs_service, "-", "")
  app_cluster_name        = "${var.project}-${local.app_short_name}-${local.cluster_name_suffix}"
  mymail_cluster_name     = "${var.project}-${local.mymail_short_name}-${local.cluster_name_suffix}"
  cloudbuild_cluster_name = "${var.project}-${local.cloudbuild_short_name}-${local.cluster_name_suffix}"
  relayfe_cluster_name    = "${var.project}-${local.relayfe_short_name}-${local.cluster_name_suffix}"
  relayrs_cluster_name    = "${var.project}-${local.relayrs_short_name}-${local.cluster_name_suffix}"
}