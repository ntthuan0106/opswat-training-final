resource "null_resource" "deploy_docker_compose" {
  connection {
    type        = "ssh"
    host        = aws_instance.ec2_instance.public_ip
    user        = "ec2-user"
    private_key = file(local_file.tf_key.filename)
    timeout = "2m"
  }

  provisioner "file" {
    source      = "${path.cwd}/../../../docker/Docker-compose.yaml"
    destination = "/home/ec2-user/Docker-compose.yaml"
  }

  provisioner "remote-exec" {
    inline = [
      "cd /home/ec2-user",
      "export DOCKER_USERNAME=${var.DOCKER_USERNAME}",
      "export DOCKER_PASSWORD=${var.DOCKER_PASSWORD}",
      "sudo docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD",
      "sudo docker compose -f './Docker-compose.yaml' up -d --build"
    ]
  }
  depends_on = [
    aws_instance.ec2_instance,
    local_file.tf_key
  ]
}
