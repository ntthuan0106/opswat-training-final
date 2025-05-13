locals {
  azs = [for i in range(var.amount_of_pub_subnet) : "${var.region}${element(["a", "b", "c"], i)}"]
}
