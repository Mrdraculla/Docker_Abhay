\# AWS Infrastructure Deployment Using Terraform



\## Project Overview



This project demonstrates Infrastructure as Code (IaC) using Terraform to deploy a Flask backend and Express frontend application on AWS through three different architectures.



\*\*AWS Region:\*\* Asia Pacific (Sydney) – `ap-southeast-2`



\*\*GitHub Repository:\*\* https://github.com/Mrdraculla/Docker\_Abhay



\## Project Architectures



\### Part 1 – Single EC2 Deployment



\- Flask backend and Express frontend deployed on one EC2 instance.

\- Nginx configured as a reverse proxy.

\- Terraform provisions the EC2 instance and security group.

\- Application tested successfully through the public endpoint.



Folder: `part1-single-ec2/`



\### Part 2 – Separate EC2 Deployment



\- Frontend and backend deployed on separate EC2 instances.

\- Express frontend communicates with Flask backend using its private IP.

\- Security groups restrict backend access to the frontend security group.

\- Application form submission tested successfully.



Folder: `part2-separate-ec2/`



\### Part 3 – Docker, ECR and ECS Deployment



\- Flask and Express applications packaged as Docker containers.

\- Container images stored in Amazon ECR.

\- Applications deployed using Amazon ECS with AWS Fargate.

\- AWS Cloud Map provides private backend service discovery.

\- Application Load Balancer exposes the frontend.

\- Security groups control communication between the ALB, frontend and backend.



Folder: `part3-ecs-ecr-alb/`



\## Project Structure



```text

Terraform\_Abhay/

├── docker/

│   ├── backend/

│   └── frontend/

├── documentation/

├── part1-single-ec2/

├── part2-separate-ec2/

├── part3-ecs-ecr-alb/

├── screenshots/

│   ├── Part1\_Single\_EC2/

│   ├── Part2\_Separate\_EC2/

│   ├── Part3\_ECS\_ECR\_ALB/

│   └── Setup/

├── state-bootstrap/

├── .gitignore

└── README.md

```



\## Terraform State Management



Terraform remote state is configured using an Amazon S3 bucket.



\- Backend: Amazon S3

\- Region: `ap-southeast-2`

\- State files use separate keys for each deployment.

\- State bucket is retained after infrastructure cleanup.



The `state-bootstrap/` folder contains the Terraform configuration used to provision the state bucket.



\## Prerequisites



\- AWS account with appropriate IAM permissions

\- Terraform CLI

\- AWS CLI

\- Docker

\- Git



\## Deployment Instructions



Navigate to the required deployment folder.



Initialize Terraform:



```bash

terraform init

```



Validate the configuration:



```bash

terraform fmt

terraform validate

```



Review the execution plan:



```bash

terraform plan -out=tfplan

```



Apply the infrastructure:



```bash

terraform apply tfplan

```



After testing, destroy the resources:



```bash

terraform destroy

```



Repeat the process for the required deployment configuration.



\*\*Note:\*\* Part 3 uses existing Amazon ECR repositories and container images. Ensure the required images are available in ECR before deployment.



\## Testing and Verification



All three deployment configurations were successfully deployed and tested.



\- Part 1: Flask and Express application tested successfully on a single EC2 instance.

\- Part 2: Frontend-to-backend communication verified across separate EC2 instances.

\- Part 3: ECS services, Fargate tasks, ALB target health and application form submission verified successfully.



Screenshots documenting the deployment, infrastructure and application tests are available in the `screenshots/` directory.



\## AWS Resource Cleanup



All three deployment configurations were destroyed after successful testing to avoid unnecessary AWS charges.



The S3 Terraform state bucket and existing ECR repositories were retained.



\## Security Notes



\- Never commit AWS access keys, secret keys, PEM files or Terraform state files.

\- `.gitignore` excludes sensitive and temporary Terraform files.

\- Use IAM roles and least-privilege permissions wherever possible.



\## Author



Abhay



GitHub: https://github.com/Mrdraculla/Docker\_Abhay



