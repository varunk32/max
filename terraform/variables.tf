  
variable "instance_name" {
  description = "Name to be used for EC2 instance"
  type        = string
  default     = "ansible-tf-ec2"
}

variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3.nano"
}

variable "instance_key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = "test_2"
}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  type        = bool
  default     = false
}

variable "instance_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = { "Env"      = "Test" }
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  type        = list(any)
  default     = [
    {
      volume_type = "gp3"
      volume_size = 15
    },
  ]

}

