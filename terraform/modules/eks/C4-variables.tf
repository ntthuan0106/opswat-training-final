# NETWORK
variable "region"{
    type = string
    default = "us-east-1"
    description = "EKS located region"
}

variable "vpc_eks_name" {
  type = string
  description = "VPC name"
}

variable "eks_cidr_block" {
  type = string
  description = "EkS CIDR block"
  default = "172.16.0.0/16"
}

variable "amount_of_pub_subnet"{
    type = number
    default = 2
    description = "Number public subnets in cluster"
    validation {
      condition = var.amount_of_pub_subnet >=2
      error_message = "Specify at list 2 public subnet"
    }
}

# CLUSTER
variable "cluster_name" {
  type = string
  description = "EKS cluster name"
}
variable "k8s_version" {
  type = string
  description = "K8s version"
}
variable "enabled_ELB" {
  type = bool
  default = true
  description = "Enable Elastic Load Balancing"
}
variable "self_managed_addons" {
  type = bool
  default = false
}

# NODE GROUP
variable "node_group_name"{
    type = string
    description = "EKS node group name"
}
variable "desired_size" {
  type = number
  default = 1
  description = "Desire EKS node"
}
variable "min_size" {
  type = number
  default = 1
  description = "Min EKS node"
}
variable "max_size" {
  type = number
  default = 2
  description = "Max EKS nodes"
}
variable "eks_instance_types" {
  type = list(string)
  description = "EKS instance types"
  default = ["t3.medium"]
}
variable "ami_id_name" {
  type = string
  description = "AMI id"
}
variable "node_group_capatity_type" {
  type = string
  default = "SPOT"
}
# ADDON
variable "eks_addon_list" {
  type = list(object({
    name =string
    version = optional(string)
  }))
}
# SECRETS
variable "ARGO_ADMIN_PASSWORD" {
  type = string
  sensitive = true
}
# Tags list
variable "tag_env" {
  type = string
}
