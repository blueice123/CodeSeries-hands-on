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

sudo git clone https://github.com/blueice123/CodeSeries-hands-on.git
sudo mv /CodeSeries-hands-on/flask-example /home/ec2-user/
sudo chown -R ec2-user:ec2-user /home/ec2-user/
cd /home/ec2-user/flask-example/
virtualenv /home/ec2-user/flask-example/venv
. ./venv/bin/activate
pip3 install -r requirements.txt
python ./01-hello-world/hello.py &
