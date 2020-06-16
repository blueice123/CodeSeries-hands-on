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

## update awscli to 2ver
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin

## Source code install & Excute Python code
sudo git clone https://github.com/blueice123/CodeSeries-hands-on.git
sudo mv /CodeSeries-hands-on/flask-example /home/ec2-user/
sudo chown -R ec2-user:ec2-user /home/ec2-user/
cd /home/ec2-user/flask-example/
virtualenv /home/ec2-user/flask-example/venv
. ./venv/bin/activate
pip3 install -r requirements.txt
python ./01-hello-world/hello.py &
