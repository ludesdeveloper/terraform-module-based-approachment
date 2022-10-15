# **TERRAFORM MODULE BASED APPROACHMENT**
### **Requirement**
1. Terraform installed (**Tested on Terraform v1.2.8**)
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
### **Execute Terraform**
1. Go to root folder then preview changes with command below
```
terraform plan
```
2. To apply, type command below
```
terraform apply -input=false -auto-approve
```
3. Check in your AWS Console GUI, don't forget to change region to *ap-southeast-1*
4. To destroy infrastructore, type command below
```
terraform destroy -input=false -auto-approve
```
