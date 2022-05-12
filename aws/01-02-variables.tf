# This file is to set generic variables for the resources
# It includes the default value and type. It can be overridden 
# by a tf.vars file

# Set the name of the project
variable "app_name" {
  description = "Project name"
  type        = string
}

# Set the docker image to deploy to the ecs cluster
variable "docker_image" {
  description = "The docker image to deploy for the cluster"
  type        = string
}

# Set a prefix name for the project 
variable "app_prefix" {
  description = "Prefix name to add to all created resources for project"
  type        = string
}

# Set the name of the enviroment ie, prod, stage, dev
variable "environment" {
  description = "Environment variable used as prefix"
  type        = string
}

# Set the default region
variable "aws_region" {
  description = "Region in which aws resources are created"
  type        = string
  default     = "ap-southeast-1"
}

# Author of the infrastructure configuration
variable "author" {
  description = "Author of the config file"
  type        = string
  default     = "Analytics Member"
}

# The appropriate business division
variable "business_divsion" {
  description = "Business division of the coorporation"
  type        = string
  default     = "Analytics"
}
