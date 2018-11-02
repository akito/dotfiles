#!/bim/bash
yum install -y epel-release
yum install -y dnf
dnf -y update

#apache2
dnf -y install httpd
apachectl enable
apachectl start 

#MySQL
#dnf install mysql-server
#systemctl start mysql-server

#php
dnf install php
echo '<?php phpinfo(); ?>' > /var/www/html/phpinfo.php
apachectl restart
