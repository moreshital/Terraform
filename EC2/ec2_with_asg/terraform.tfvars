
terragrunt = {

    remote_state {
    backend = "s3"
    config {
    bucket = "terraform-state"
    key   = "ap-south-1/production/EC2/service_1/terraform.tftstate"
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
        "-var-file=${get_tfvars_dir()}/../../../../envars/ap-south-1/production.tfvars",
        "-var-file=terraform.tfvars"
      ]
  }
}
}

### Service varibles

entity = "Service 1"
application = "service_1"
service_name = "service_1"
ami_name_pattern = "*prod.service_1*"
ami_name_regex = "^prod.service_1"

## Security Group parameters
security_groups_name = "Aggregation_service-sg"
## Autoscaling parameters
min_size = 2
max_size = 2
desired_capacity = 2
instance_type = "c4.2xlarge"
key_name = "devops"
userdata = "userdata.sh"

## Internal LB Parameter
instance_port = 8080
instance_protocol = "HTTP"
lb_port = 80
lb_protocol = "HTTP"
log_bucket = "logs"
elb_healthcheck_path = "TCP:8080"
cert_acm_arn="arn:aws:iam::9016807XXXXX:server-certificate/rc_wcard_2018"
internal_status = "true"

## Load Balancer parameters
tg_port = 8080
log_bucket = "logs"
alb_healthcheck_path = "/api"
cert_acm_arn="arn:aws:iam::9016807XXXXX:server-certificate/rc_wcard_2018"

## R53 parameters
zone_id = "Z2IDUVEXXXXXX"
dns_record_name = "service1.xyz.com."
