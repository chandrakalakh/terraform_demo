provider "aws" {
  access_key = "AKIAIKD5NXF7LQEKKMDA"
  secret_key = "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"
  region     = "us-east-1"
}

# Create an EC2 instance
resource "aws_instance" "remote" {
  # AMI ID for Amazon Linux AMI 2016.03.0 (HVM)
  ami           = "ami-098bb5d92c8886ca1"
  instance_type = "t2.micro"
  key_name      = "devops"

  provisioner "remote-exec" {
    inline = [
      "sudo yum -y install epel-release",
      "sudo yum -y install nginx",
      "sudo service nginx start"
    ]
    connection {
      host = "${aws_instance.remote.public_ip}"
      type = "ssh"
      user = "ec2-user"
      private_key = "${file("./devops.pem")}"
    }
  }
  }
