# add additional network acls if additional vpcs are created
# if attempt to destroy this acl after creation, it will not be removed. Will need to clean it up manually. Only destroying the VPC entirely will take this acl with it. This includes just removing the rules. Keeping this object deployed but destroying all rules will still leave it untouched.
resource "aws_default_network_acl" "default_vpc" {
  default_network_acl_id = "acl-0ebd41c34cdfa2818"

# SSH rules - TCP 22
  ingress {
    protocol    = "tcp"
    rule_no     = 20
    action      = "allow"
    cidr_block  = "10.0.0.0/8"
    from_port   = 22
    to_port     = 22
  }

  ingress {
    protocol    = "tcp"
    rule_no     = 30
    action      = "allow"
    cidr_block  = "172.16.0.0/12"
    from_port   = 22
    to_port     = 22
  }

  ingress {
    protocol    = "tcp"
    rule_no     = 40
    action      = "allow"
    cidr_block  = "192.168.0.0/16"
    from_port   = 22
    to_port     = 22
  }

# RDP rules - TCP 3389
  ingress {
    protocol    = "tcp"
    rule_no     = 50
    action      = "allow"
    cidr_block  = "10.0.0.0/8"
    from_port   = 3389
    to_port     = 3389
  }

  ingress {
    protocol    = "tcp"
    rule_no     = 60
    action      = "allow"
    cidr_block  = "172.16.0.0/12"
    from_port   = 3389
    to_port     = 3389
  }

  ingress {
    protocol    = "tcp"
    rule_no     = 70
    action      = "allow"
    cidr_block  = "192.168.0.0/16"
    from_port   = 3389
    to_port     = 3389
  }

# Deny / allow all default rules
  ingress {
    protocol    = "tcp"
    rule_no     = 80
    action      = "deny"
    cidr_block  = "0.0.0.0/0"
    from_port   = 22
    to_port     = 22
  }

  ingress {
    protocol    = "tcp"
    rule_no     = 90
    action      = "deny"
    cidr_block  = "0.0.0.0/0"
    from_port   = 3389
    to_port     = 3389
  }

  ingress {
    protocol    = -1
    rule_no     = 100
    action      = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 0
    to_port     = 0
  }

# Egress allow all
  egress {
    protocol    = -1
    rule_no     = 100
    action      = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 0
    to_port     = 0
  }

}
