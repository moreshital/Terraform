
# terraform {
#   backend "s3" {
#     bucket = "g24x7-terraform-state"
#     key   = "ap-south-1/production/EC2/ums/terraform.tftstate"
#     region = "ap-south-1"
#   }
# }


terragrunt = {

    remote_state {
    backend = "s3"
    config {
    bucket = "terraform-state"
    key   = "VPC/terraform.tftstate"
    region = "ap-south-1"
  }
  }
  terraform {
    extra_arguments "conditional_vars" {
      commands = [
        "apply",
        "plan",
        "import",
        "push",
        "refresh",
        "destroy"
      ]

      required_var_files = [
        "${get_tfvars_dir()}/terraform.tfvars"
      ]
        arguments = [
        "-var-file=${get_tfvars_dir()}/../../../envars/ap-south-1/production.tfvars",
        "-var-file=terraform.tfvars"
      ]
  }
}
}

## Security Group parameters
security_groups_name = "alb-sg"
elb_security_groups_name = "elb-sg"
## Autoscaling parameters
min_size = 1
max_size = 1
desired_capacity = 1
instance_type = "t2.medium"
key_name = "devops"
userdata = "userdata.sh"
security_groups = [""]
## Load Balancer parameters
tg_port = 8080
log_bucket = "logs"
alb_healthcheck_path = "/"
cert_acm_arn="arn:aws:iam::9016xxxxxxx:server-certificate/rc_wcard_2018"

## R53 parameters
zone_id = "ZP97RAXXXXXXX"
dns_record_name = "xyz.com."
