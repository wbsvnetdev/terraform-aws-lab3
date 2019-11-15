#!/bin/bash
yum install httpd -y
service httpd start
touch /var/www/html/index.html
IP_ADDR=`curl -s http://whatismyip.akamai.com/`
echo "Yeah !!! Hello there , IT WORKS :) " >> /var/www/html/index.html
echo "IP Address : $IP_ADDR" >> /var/www/html/index.html
chkconfig httpd on
