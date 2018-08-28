# Terraform modules:
List of Terraform Modules to create AWS Resources.

## Modules
#### lc : 
Module to Create Launch Configuration for autoscaling group. LC module accept below variables:

```
 name: "Launch Config name"
instance_type:  "Instance type"
key_name: "SSH Key used for EC2 Login"
security_groups: "Security Group attached to LC"
role_name: "Instance IAM Role Name"
userdata: "Userdata filename"
ami_id: "AMI For Launch Config"
```

### tg:
Module to Create ALB Target Group. tg module accept below variables:

 ``` 
name: "AWS ALB Name"
http_code: "HTTP Code for health check"
entity: "Entity Name for Tag"
environment: "Environment Name for Tag"
alb_port: "ALB Port Number"
alb_check_path: "Instance Healthcheck path"
cert_acm_arn: "ACM for ARN for SSL"
alb_arn: "ALB arn Attached to Target Group"
vpc_id: "Target Group VPC id"  
 ```

### alb
Module to Create Application loadbalancer. tg module accept below variables:

```
name: "AWS ALB Name"
internal_value: "Accept True/False to make ALB Internal/External"
entity: "Entity Name"
environment: "Environment Name for Tag"
subnet_ids: "A list of subnet IDs"
security_groups: "A list of SG IDs"
```

### ec2
Module to launch EC2 instance. ec2 module accept below variables:

```
instance_type: "Instance type, see a list at: https://aws.amazon.com/ec2/instance-types/"
name: "EC2 INSTANCE TYPE"
key_name: "SSH Key used for EC2 Login"
application: "Application tag"
application-type: "Application-type Tag"
entity: "Entity Tag"
security_groups: "a comma separated lists of security group IDs"
vpc_id: "VPC ID"
ami_id: "AMI ID to launch EC2 Instance"
subnet_id:"A subnet id"
environment: "Environment tag"
```

### elb
Module to create classtic loadbalancer. elb accept below variables:

```
name: "Name of loadbalancer"
elb_type:  "Define if elb is internal or external"
cert_acm_arn: "SSL cert arn"
security_groups: "Securtiy group attatched to ELB"
subnet_ids: "Subnet ids attatched to elb"
environment: "Environment Tag"
entity: "Entity tag"
```

### nlb
Module to create Network loadbalancer. nlb module accept below variables:
```
name: "Name of nlb"
internal_lb_value: "elb_type:  "Define if nlb is internal or external"
subnet_ids: "Subnet ids attatched to nlb"
application: "appliction tag"
environment: "environment tag"
entity: "Entity tag"
```

### vpc
module to create below resources:
`aws_vpc`
`aws_eip`
`aws_subnet`
`aws_route`
`aws_route_table`
`aws_nat_gateway`
`aws_internet_gateway`
`aws_route_table_association`

vpc module accept below varables:

```
vpc_name: "VPC name"
cidr: "VPC Cidr value"
rds_subnets: "RDS Subnet cidr"
external_subnets: "External subnet cidr"
internal_subnets: "Internal subnet cidr"
elasticache_subnets: "Elasticcache subnet cidr"
availability_zones: "VPC availiablity zones"
entity: "Entity tag"
environment: "Environment tag"
```

### rds
rds module create below aws resources:
`db_subnet_group`
`db_instance`

rds module accept below variables:
```
name: "RDS name"
environment: "Environment tag"
entity: " Entity tag"
application: "Application Tag"
application-team: "Application Team tag"
engine: "RDS DB Engine type"
engine_version: "RDS db engine version"
port: "RDS port"
username: "DB master username"
password: DB Password
multi_az: "boolean if DB is multi AZ or not"
backup_retention_period: "RDS Backup retention period"
backup_window: "Backup windows"
monitoring_interval: "Time internval for monitoring"
monitoring_role_arn: "IAM Role assigned"
instance_class: "RDS Instance Class/Type"
storage_type: "RDS Storage type e.g. SSD/Magnetic"
allocated_storage: "RDS DB storage"
publicly_accessible: "Boolean if RDS is publicily accessible"
vpc_id: "RDS VPC id"
security_groups: "Security group attached to RDS"
subnet_ids: "Subnet ids to create RDS subnet group"
snapshot_identifier:  "Snapshot identifier/name"
```

### elasticache 
elasticache module create below AWS reosurces:
`aws_elasticache_subnet_group`
`aws_elasticache_cluster`

module to create AWS elasticache resources. elasticache accept below variables:

```
name: "Name of elasticache instance"
engine: "Elasticache instance engine  redis/memcache"
engine_version: "redis/memcache engine version"
port: "Elasticache port"
subnet_ids: "Subnet id attched to elasticache instance"
security_groups: "Security group attached"
num_cache_nodes: "Number of cache nodes"
parameter_group_name: "parameter group used"
environment: "Environment tag"
entity: "Entity Tag"
```

### nlb-tg
module to create nlb target group and nlb listner. nlb-tg accept below variables:
```
name: "NLB tg name"
http_code: "http success for active instance"
nlb_port: "port for instance health check"
nlb_arn: "nlb arn value "
nlb_check_path: "instance healthcheck path"
entity: "Entity tag"
environment: "Environment Tag"
```

### asg_alb
module to create autoscaling group for alb based application. asg_alb accept below variables:

```
name: "Name of ASG"
launch_configuration: "Launch configuration Name"
target_group_arn: "ALB_TG arn attached to ASG"
desired_capacity: "Desired Instance count"
max_size: "Max instance count for Scaling"
min_size: "Minimum instance count"
availability_zones: "availability_zones to run instances"
vpc_id: "VPC ID"
subnet_ids: "Subnet id for instances"
application: "Application Tag"
entity: "Entity Tag"
environment: "Environment Tag"
```

### asg_elb
module to create autoscaling group for alb based application. asg_alb accept below variables:

```
name: "Name of ASG"
launch_configuration: "Launch configuration Name"
elb_name: "ELB name attached to ASG"
desired_capacity: "Desired Instance count"
max_size: "Max instance count for Scaling"
min_size: "Minimum instance count"
availability_zones: "availability_zones to run instances"
vpc_id: "VPC ID"
subnet_ids: "Subnet id for instances"
application: "Application Tag"
entity: "Entity Tag"
environment: "Environment Tag"
```

### ecs_cluster
Module to create ECS cluster, ecs_cluster accespt below variables:
```
name: "Name of ECS Cluster"
```

### ecs_service
ecs_service module create below AWS resources:
`aws_cloudwatch_log_group`
`aws_ecs_task_definition`
`aws_ecs_service`
`aws_appautoscaling`

ecs_service accept below variables:
```
name: "Name of ECS Service"
target_group_arn: "Target group arn for ECS service"
instance_volume_path: "EC2 Instance volume path"
volume_name: "Instance Volume name"
container_mount_path: "Container mount path"
container_name: "ECS container name for Task Defination"
container_port: "ECS Container port"
desired_count: "Desired ECS count"
max_capacity:  "Max ECS instance count"
min_capacity: "Min instance count"
availability_zones: "ECS availability zones"
docker_image: "ECR Url"
docker_tag: "ECR tag"
awslogs_group: "AWS LogGroup Name"
host_port: "Host port for port mapping"
cluster_name: "ECS Cluster Name"
container_definition_file: "Container definitation File Name"
ecs_iam_role: "ECS Iam Role"
aws_loggroup_condition: "ECS LogGroup Create Condition 0: if log group already exist. 1: to create new loggroup"
environment: "Environment Tag"
entity: "Entity Tag"
```

### lifecycle_hook
Module to create ASG LifeCycle Hook. accept below modules:
```
asg_name: "AWS ASG Name"
heartbeat_timeout: "ASG Lifecycle hook timeout"
```

### security-groups: 
Module to create security group . security-groups accept below varialbes:
```
name: "Name Of Security Group"
security_group: "Name Of Security Group Optional"
http_port: "HTTP Port of ELB/ALB"
https_port: "Https port for ELB/ALB "
ssh_port: " SSH Port Number"
rds_port: "RDS Port"
elasticache_port: "Elasticache port"
vpc_id: "VPC id for Security Group creation"
cidr: "VPC Cidr block"
environment: "Environment Tag"
entity: "Entity Tag"
```

### asg_scaling_policy: 
Module for ASG Scaling Policy as per CPU load. Module Accept below variables:

```
name: "ASG Name"
namespace: "Namespace Value for Alarm"
asg_name: "ASG Name"
asg_arn: "ASG Arn"
```

### nlb_alarms: 
Module to Create Cloudwatch NLB Alarm. nlb_alarms module accept below variables:

```
lb_name: "NLB Name which will be used for nlb alarms"
lb_arn: "nlb arn used for alarms"
asg_name: "ASG Name"
asg_arn: "ASG ARN"
tg_name: "Target Group Name"
tg_arn: "Target Group ARn"
slack_notifications_arn: "Slack channel arn for notification"
```

### cloudwatch_alarms

### elb_cloudwatch_alarms
module to create ELB Cloudwatch alarms. elb_cloudwatch_alarms accept below variables:
```
lb_name: "NLB Name which will be used for nlb alarms"
lb_arn: "nlb arn used for alarms"
asg_name: "ASG Name"
asg_arn: "ASG ARN"
tg_name: "Target Group Name"
tg_arn: "Target Group ARn"
slack_notifications_arn: "Slack channel arn for notification"
```

### ecs_service_scaling_policy:
Module to create ECS service scaling policy. ecs_service_scaling_policy accept below variables:

```
service_name: "ECS Service Name"
cluster_name: "ECS Cluster Name"
asg_name: "ECS Service ASG Name "
asg_arn: "ECS Service ASG Arn"
slack_notifications: "Slack Notification Arns for alarm"
```

### ecs_cluster_scaling_policy:
Module to create ECS service scaling policy. ecs_cluster_scaling_policy accept below variables:
```
cluster_name: "ECS Cluster Name"
asg_name: "ECS Cluster ASG Name "
asg_arn: "ECS Cluster ASG Arn"
slack_notifications: "Slack Notification Arns for alarm"
```

### asg_scaling_connection_count
Module to create Scaling policy based on Target Group connection Count. asg_scaling_connection_count accept below variables:
```
lb_name: "Loadbalancer Name"
lb_arn: "Loadbalancer ARN"
asg_name: "Autosaling Group"
asg_arn: "Autoscaling arn"
tg_name: "target name"
tg_arn: "Target arn"
slack_notifications_arn: "Slack Notification channel arn"
```
