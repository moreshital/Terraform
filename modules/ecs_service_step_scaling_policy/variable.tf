variable "service_name" {
  description = "Name of service"
}

variable "cluster_name" {
  description = "Name of ECS cluster"
}


variable "slack_notifications" {
  description = "slack Notification"
}

variable "cpu_high_thershold" {

}

variable "cpu_low_thershold" {
}

# Step scaling variables
variable "step_up_1_scaling_adjustment" {

}

variable "step_up_1_lower_bound" {

}

variable "step_up_1_upper_bound" {

}

variable "step_up_2_scaling_adjustment" {

}

variable "step_up_2_lower_bound" {

}

variable "step_up_2_upper_bound" {

}

variable "step_up_3_scaling_adjustment" {

}

variable "step_up_3_lower_bound" {

}


variable "step_down_1_scaling_adjustment" {

}

variable "step_down_1_lower_bound" {

}


variable "step_down_1_upper_bound" {

}

variable "step_down_2_scaling_adjustment" {

}

variable "step_down_2_lower_bound" {

}


variable "step_down_2_upper_bound" {

}


variable "step_down_3_scaling_adjustment" {

}

variable "step_down_3_lower_bound" {

}


variable "step_down_3_upper_bound" {

}
