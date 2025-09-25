variable "peer_vpc_id_dev" {
  description = "vpc id of the account getting connected to"
  type        = string
}

variable "peer_vpc_id_uat" {
  description = "vpc id of the account getting connected to"
  type        = string
}

variable "peer_vpc_id_prod" {
  description = "vpc id of the account getting connected to"
  type        = string
}

variable "dev_account_id" {
  description = "dev aws account id"
  type        = string
}

variable "uat_account_id" {
  description = "uat aws account id"
  type        = string
}

variable "prod_account_id" {
  description = "prod aws account id"
  type        = string
}

