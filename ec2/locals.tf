locals {
  user_data_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    echo "Sahar Bittman project: Private IP: $(hostname -I)" > /var/www/html/index.html
    systemctl start nginx
    systemctl enable nginx
    EOF
}
