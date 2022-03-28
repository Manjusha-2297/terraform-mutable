resource "null_resource" "app-deploy" {
  count = length(local.all_instance_ip)
  triggers = {
    abc = timestamp()
  }
  provisioner "remote-exec" {
    connection {
      host     = element(local.all_instance_ip, count.index)
      user     = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["ssh_user"]
      password = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["ssh_password"]
    }

    inline = [

      "ansible-pull -i localhost, -U https://github.com/Manjusha-2297/ansible.git roboshop-pull.yml -e COMPONENT=${var.component} -e ENV=${var.env} -e APP_VERSION=${var.APP_VERSION}"
    ]
  }
}