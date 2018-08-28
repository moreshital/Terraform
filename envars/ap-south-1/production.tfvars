## Environment variables
region = "ap-south-1"
availability_zones = ["ap-south-1a", "ap-south-1b"]
environment = "Production"
key_name = "devops"

## Security Groups
web_private_security_group = []
web_public_security_group  = []
app_private_security_group = []
app_public_security_group  = []
lb_private_security_group  = ["sg-ffe83xxx"]
lb_public_security_group   = ["sg-ffe83xxx"]
elb_private_security_group  = ["sg-f2578xxx"]
elb_public_security_group = ["sg-f2578xxx"]
db_private_security_group  = []
common_security_group = ["sg-0165af59d52aefxxxx"]

## Networking
vpc_id = "vpc-801bexxx"
web_public_subnet_ids = ["subnet-6512bxxx", "subnet-ec7b0xxx"]
web_private_subnet_ids = []
app_public_subnet_ids = []
app_private_subnet_ids = ["subnet-43696xxx", "subnet-579f5xxx"]
db_private_subnet_ids = ["subnet-8c686xxx", "subnet-959e5xxx"]
lb_public_subnet_ids  = ["subnet-ce686xxx", "subnet-d69e5xxx"]
lb_private_subnet_ids = ["subnet-64077xxx", "subnet-1013bxxx"]
