# resource "null_resource" "name" {

#   # ssh into the ec2 instance 
#   connection {
#     type        = "ssh"
#     user        = "ec2-user"
#     private_key = file("~/Downloads/ec2_key.pem")
#     host        = aws_instance.ec2_instance.public_ip
#   }

#   # copy the password file for your docker hub account
#   # from your computer to the ec2 instance 
#   provisioner "file" {
#     source      = "~/Downloads/docker_password.txt"
#     destination = "/home/ec2-user/docker_password.txt"

#   }
#   # copy the dockerfile from your computer to the ec2 instance 
#   provisioner "file" {
#     source      = "Dockerfile"
#     destination = "/home/ec2-user/Dockerfile"
#   }

#   # copy the deployment.sh from your computer to the ec2 instance 
#   provisioner "file" {
#     source      = "deployment.sh"
#     destination = "/home/ec2-user/deployment.sh"
#   }

#   # set permissions and run the build_docker_image.sh file
#   provisioner "remote-exec" {
#     inline = [
#       "sudo chmod +x /home/ec2-user/deployment.sh",
#       "sh /home/ec2-user/deployment.sh",

#     ]
#   }

#   # wait for ec2 to be created
#   depends_on = [aws_instance.ec2_instance]

# }
