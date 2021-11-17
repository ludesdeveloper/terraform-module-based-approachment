# **TERRAFORM MODULE BASED APPROACHMENT**
This is example of how to use module based approachment in terraform.
In this example we will use 2 use case:
1. Provision EC2 instance with dynamic ip
2. Provision EC2 instance with static ip
### **Requirement**
1. Terraform installed
2. AWS Cli installed and configured with existing account
### **How to Use It**
1. Clone respository
```
git clone https://github.com/ludesdeveloper/terraform-module-based-approachment.git
```
2. To generate keypair, cd to scripts directory
```
cd terraform-module-based-approachment/scripts
```
3. Type command below
```
./generate-keypair.sh
```
4. Go to root folder
```
cd ..
```
### **Initiating Terraform**
1. Type command below to initiate terraform
```
terraform init
```
### **Provision EC2 with Dynamic IP**
1. Go to root folder then preview changes with command below
```
terraform plan
```
2. To apply, type command below
```
terraform apply -input=false -auto-approve
```
3. Check in your AWS Console GUI, don't forget to change region to *ap-southeast-1*
### **Provision EC2 with Static IP**
1. Go to examples folder *ec2_static_ip* 
```
cd examples/ec2_static_ip
```
2. Copy code in main.tf(inside ec2_static_ip folder), then go to root folder
```
cd ../..
```
4. Preview changes with command below
```
terraform plan
```
5. To apply, type command below
```
terraform apply -input=false -auto-approve
```
3. Check in your AWS Console GUI, don't forget to change region to *ap-southeast-1*
