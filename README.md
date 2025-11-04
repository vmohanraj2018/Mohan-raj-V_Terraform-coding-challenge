# Mohan-raj-V_Terraform-coding-challenge
CHALLENGE: Infrastructure Provisioning with Terraform

SOLUTION:
This repository consits of main.tf,variables.tf,outputs.tf files
Steps to run the automation :
1.Create EC2 server in AWS on ap-south-1 region with key pair and select ubuntu version 24.04 as AMI

2.Connect the server with putty using keypair and login server by entering "ubuntu"

3.Become a root using this command | $ sudo su -

4.Install the terraform by browsing terraform ubuntu installation and follow the process in terraform hashicorp installation page

5.Creater a Directory Terraform_challenge | # mkdir Terraform_challenge

6.Create main.tf,variables.tf,output.tf files in that directory | # cd Terraform_challenge/touch main.tf/touch variables.tf/outputs.tf

7.Copy the file content in repository and paste it accordingly to their names

    # vi main.tf ->paste contents from main.tf file by clicking I to enable insert mode in vim editor and after completing press ESC+:wq! to save and exit.
   
    # vi variables.tf ->paste contents from variables.tf file by clicking I to enable insert mode in vim editor and after completing press ESC+:wq! to save and exit.
   
    # vi outputs.tf ->paste contents from outputs.tf file by clicking I to enable insert mode in vim editor and after completing press ESC+:wq! to save and exit.
   
8.Now need to intialise,plan and apply to create automation sing Terraform

  * Move into directory
          # cd terraform_challenge
    
  *Initialize Terraform
          # terraform init
          
  * Validate configuration
          # terraform validate
    
  * Preview the changes
          # terraform plan -var="key_pair_name=mumbai" -var="db_password=12345678"
    
  * Apply changes
          # terraform apply -auto-approve -var="key_pair_name=mumbai" -var="db_password=12345678"

   
