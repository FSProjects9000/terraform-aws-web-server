#!/bin/bash

apt update
apt install nginx -y

cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>

<html>

<head>

<title>João's Cloud Portfolio</title>

</head>

<body>

<h1>Hello World! This is a test!</h1>

<p>This is the website hosted on the EC2 instance I deployed with Terraform. I'm writing this on user-data.sh</p>

</body>

</html>
EOF

systemctl enable nginx
systemctl start nginx