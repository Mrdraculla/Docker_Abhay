\# AWS Infrastructure Deployment Using Terraform

\## Project Deployment and Testing Report



\*\*Author:\*\* Abhay  

\*\*Cloud Provider:\*\* Amazon Web Services (AWS)  

\*\*Infrastructure as Code:\*\* Terraform  

\*\*AWS Region:\*\* Asia Pacific (Sydney) – `ap-southeast-2`  

\*\*GitHub Repository:\*\* https://github.com/Mrdraculla/Docker\_Abhay



\---



\## 1. Introduction



The objective of this project was to deploy a Flask backend and Express frontend application on AWS using Terraform.



The project demonstrates three different infrastructure architectures:



1\. Single EC2 instance deployment.

2\. Separate EC2 instances for frontend and backend.

3\. Containerized deployment using Docker, Amazon ECR, Amazon ECS, AWS Fargate and an Application Load Balancer.



Terraform was used to provision and manage AWS infrastructure through reusable configuration files.



\## 2. Application Architecture



The application consists of two components.



\### Flask Backend



\- Developed using Python and Flask.

\- Runs on port 5000.

\- Provides an API endpoint for form submissions.

\- Accepts name, email and message data.

\- Returns a successful JSON response after submission.



\### Express Frontend



\- Developed using Node.js and Express.

\- Runs on port 3000 internally.

\- Provides a contact form interface.

\- Sends submitted form data to the Flask backend.

\- Uses the `BACKEND\_URL` environment variable for backend communication.



The application was tested using the message:



\*\*Form submitted successfully!\*\*



\## 3. Part 1 – Single EC2 Deployment



\### Architecture



Both Flask and Express were deployed on a single Amazon EC2 instance.



Components:



\- One Ubuntu EC2 instance.

\- Flask application running through Gunicorn.

\- Express frontend application.

\- Nginx reverse proxy.

\- AWS security group.



\### Implementation



Terraform configuration files:



\- `main.tf`

\- `variables.tf`

\- `outputs.tf`

\- `user\_data.sh`



The EC2 instance was provisioned using Terraform. The user-data script installed the required dependencies, configured the applications and started the required services.



Nginx was configured to receive HTTP requests and route them to the appropriate application service.



\### Testing



The following tests were completed:



\- EC2 instance deployment verified.

\- Flask backend response verified.

\- Express frontend accessed through the public endpoint.

\- Contact form submitted successfully.

\- Backend response confirmed successful submission.



\### Result



The single EC2 architecture was successfully deployed and tested.



\*\*Evidence:\*\* `screenshots/Part1\_Single\_EC2/`



\## 4. Part 2 – Separate EC2 Deployment



\### Architecture



The frontend and backend were deployed on two separate EC2 instances.



Components:



\- Frontend EC2 instance.

\- Backend EC2 instance.

\- Frontend security group.

\- Backend security group.

\- Private IP communication between the instances.



\### Implementation



Terraform configuration files:



\- `main.tf`

\- `variables.tf`

\- `outputs.tf`

\- `user\_data/backend.sh`

\- `user\_data/frontend.sh`



Terraform provisioned both EC2 instances and their associated security groups.



The Express frontend was configured to communicate with the Flask backend using its private IP address.



The backend security group allowed TCP port 5000 traffic only from the frontend security group.



This restricted direct public access to the backend service.



\### Testing



The following tests were completed:



\- Both EC2 instances deployed successfully.

\- Frontend and backend instance connectivity verified.

\- Backend private IP connectivity tested.

\- Backend security group restriction verified.

\- Frontend application accessed successfully.

\- Contact form submission returned a successful response.



\### Result



The separate EC2 architecture was successfully deployed and tested.



\*\*Evidence:\*\* `screenshots/Part2\_Separate\_EC2/`



\## 5. Part 3 – Docker, ECR, ECS, Fargate and ALB Deployment



\### Architecture



The Flask backend and Express frontend were containerized and deployed using Amazon ECS with AWS Fargate.



Components:



\- Docker containers for Flask and Express.

\- Amazon Elastic Container Registry (ECR).

\- Amazon Elastic Container Service (ECS).

\- AWS Fargate.

\- Application Load Balancer (ALB).

\- Target group and HTTP listener.

\- AWS Cloud Map private DNS service discovery.

\- CloudWatch log groups.

\- IAM task execution role.

\- Application-specific security groups.



\### Container Images



The following existing ECR repositories and images were used:



\- `abhay-flask-backend`

\- `abhay-express-frontend`



Terraform retrieved the existing repository images and used their image digests in the ECS task definitions.



\### Implementation



Terraform configuration files:



\- `main.tf`

\- `variables.tf`

\- `outputs.tf`

\- `README.md`



Terraform provisioned the ECS cluster, task definitions, services, IAM role, security groups, Cloud Map namespace and service, CloudWatch log groups, ALB, listener and target group.



Both backend and frontend were deployed as Fargate services.



Cloud Map provided private DNS-based backend discovery. The frontend used the backend service DNS name through the `BACKEND\_URL` environment variable.



The ALB exposed the frontend through HTTP port 80.



The ECS tasks were configured with public IP assignment to allow access to AWS services such as ECR without creating a NAT Gateway.



\### Testing



The following tests were completed:



\- ECS cluster became active.

\- Backend ECS service reached 1/1 running tasks.

\- Frontend ECS service reached 1/1 running tasks.

\- Both service deployments completed successfully.

\- ALB target group reported Healthy.

\- Application accessed through the ALB DNS endpoint.

\- Contact form submitted successfully.

\- Flask backend returned a successful response through the Express frontend.



\### Result



The containerized ECS/Fargate architecture was successfully deployed and tested.



\*\*Terraform Apply Result:\*\*



`Apply complete! Resources: 17 added, 0 changed, 0 destroyed.`



\*\*Evidence:\*\* `screenshots/Part3\_ECS\_ECR\_ALB/`



\## 6. Terraform State Management



Terraform remote state was configured using Amazon S3.



A separate state key was used for each deployment:



| Configuration | S3 State Key |

|---|---|

| Part 1 | `part1/terraform.tfstate` |

| Part 2 | `part2/terraform.tfstate` |

| Part 3 | `part3/terraform.tfstate` |



The state bucket was created through the `state-bootstrap` Terraform configuration.



The S3 bucket was configured with versioning, encryption and public access blocking.



The remote state bucket was retained after deployment cleanup.



\## 7. Terraform Commands Used



The following commands were used during deployment.



\### Initialize Terraform



```bash

terraform init

```



\### Format Terraform files



```bash

terraform fmt

```



\### Validate configuration



```bash

terraform validate

```



\### Generate execution plan



```bash

terraform plan -out=tfplan

```



\### Apply infrastructure



```bash

terraform apply tfplan

```



\### Display Terraform-managed resources



```bash

terraform state list

```



\### Destroy infrastructure after testing



```bash

terraform destroy

```



These steps were performed separately for the three deployment configurations.



\## 8. Final Testing Summary



| Test | Part 1 | Part 2 | Part 3 |

|---|---|---|---|

| Terraform deployment | Passed | Passed | Passed |

| Infrastructure provisioning | Passed | Passed | Passed |

| Frontend accessibility | Passed | Passed | Passed |

| Backend connectivity | Passed | Passed | Passed |

| Form submission | Passed | Passed | Passed |

| Architecture verification | Passed | Passed | Passed |



All three architectures were successfully deployed and tested.



\## 9. AWS Resource Cleanup



After successful testing, Terraform destroy was executed for all three deployment configurations.



The infrastructure was removed to avoid unnecessary AWS charges.



Part 3 confirmed:



`Destroy complete! Resources: 17 destroyed.`



The Part 3 Terraform state list was also checked and returned no managed resources.



The EC2 instances, ECS tasks and services, ALB and other deployment resources were verified as cleaned up.



The S3 Terraform state bucket and existing ECR repositories were retained.



\## 10. Security Considerations



\- AWS credentials were not included in the project source code.

\- PEM files and private keys were excluded using `.gitignore`.

\- Terraform state files and plan files were excluded from version control.

\- Backend access was restricted through security group rules.

\- ECS task communication was restricted using dedicated security groups.

\- S3 remote state was encrypted and protected from public access.



\## 11. Conclusion



This project successfully demonstrated the use of Terraform to provision AWS infrastructure across three deployment architectures.



The single EC2 deployment demonstrated a basic application hosting model.



The separate EC2 deployment demonstrated frontend/backend separation and private network communication.



The ECS/Fargate deployment demonstrated containerized application hosting using ECR, ECS, Cloud Map and an Application Load Balancer.



All three configurations were deployed, tested and destroyed successfully.



The project demonstrates practical knowledge of Terraform, AWS infrastructure provisioning, Docker, container orchestration, networking, security groups and infrastructure cleanup.



\*\*GitHub Repository:\*\*  

https://github.com/Mrdraculla/Docker\_Abhay



