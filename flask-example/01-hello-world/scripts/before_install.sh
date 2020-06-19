#!/bin/bash
sudo yum update -y 

## Install codedeploy agent ##
sudo yum -y install ruby wget
sudo cd /home/ec2-user
sudo wget https://aws-codedeploy-ap-northeast-2.s3.ap-northeast-2.amazonaws.com/latest/install
sudo chmod +x ./install
sudo ./install auto
##############################

## Install hands-on packge ##
sudo yum install -y git python3
sudo pip3 install virtualenv

## Delete source code
sudo rm -rf /home/ec2-user/flask-example/

