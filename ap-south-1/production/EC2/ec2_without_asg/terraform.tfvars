
terragrunt = {
    remote_state {
    backend = "s3"
    config {
    bucket = "terraform-state"
    key   = "ap-south-1/production/EC2/ec2-service/terraform.tftstate"
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
entity = "ec2-service"
application = "ec2-service"
service_name = "ec2-service"

## Security Group parameters
security_groups_name = "ec2-service-sg"
albsecurity_groups_name = "ec2-service-elb-sg"

## Autoscaling parameters
min_size = 5
max_size = 5
desired_capacity = 5
instance_type = "c4.2xlarge"
key_name = "devops"
userdata = "userdata.sh"
subnet_id = "subnet-43696f09"

## Load Balancer parameters
tg_port = 8080
log_bucket = "g24x7-logs"
alb_healthcheck_path = "/"
cert_acm_arn="arn:aws:iam::901680XXXXXX:server-certificate/rc_wcard_2018"

## R53 parameters
zone_id = "Z2IDUVEAXXXXXX"
dns_record_name = "ec2-service.xyz.com."
