# Creates Security Group for DocumentDB

resource "aws_security_group" "docdb" {
    name                    = "roboshop-${var.ENV}-docdb-security-group"
    description             = "roboshop-${var.ENV}-docdb-security-group"

  ingress {
    description             = "DocDB from Private Network"
    from_port               = var.DOCDB_PORT
    to_port                 = var.DOCDB_PORT
    protocol                = "tcp"
    cidr_blocks             = [data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR, data.terraform_remote_state.vpc.outputs.VPC_CIDR]
  }

  egress {
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    cidr_blocks             = ["0.0.0.0/0"]
  }

  tags = {
    Name                    = "roboshop-${var.ENV}-docdb-security-group"
  }
}
