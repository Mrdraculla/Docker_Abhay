# Part 3 — ECS Fargate, ECR, Cloud Map and ALB

This configuration deploys the existing Flask and Express container images from ECR to AWS ECS Fargate.

## Architecture

- Existing ECR repositories: `abhay-flask-backend` and `abhay-express-frontend`
- ECS Fargate cluster with one Flask backend task and one Express frontend task
- AWS Cloud Map private DNS namespace (`abhay-tf.local`) for backend service discovery
- Application Load Balancer listening on HTTP port 80 and forwarding to Express port 3000
- Security groups restrict Express traffic to the ALB and Flask traffic to the Express task security group
- Default VPC public subnets; Fargate tasks receive public IPs for ECR image pulls
- No NAT Gateway is created

## Prerequisites

- Terraform >= 1.10
- AWS CLI configured with permission to manage ECS, EC2 networking, IAM roles, ELB, Cloud Map, CloudWatch Logs and read ECR
- Existing S3 state bucket: `terraform-abhay-tfstate-452258152284-20261112`
- Existing ECR repositories with a `latest` image tag

## Deploy

From this directory:

```cmd
terraform fmt
terraform init
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

Type `yes` when Terraform asks for confirmation.

## Verify

Get the public URL:

```cmd
terraform output application_url
```

Open the URL in a browser, submit the form, and verify the successful response.

Check ECS services:

```cmd
aws ecs list-clusters --region ap-southeast-2
aws ecs list-services --cluster abhay-tf-part3-ecs-cluster --region ap-southeast-2
```

Check task status:

```cmd
aws ecs list-tasks --cluster abhay-tf-part3-ecs-cluster --region ap-southeast-2
```

Logs are available in CloudWatch under:

- `/ecs/abhay-tf-part3/backend`
- `/ecs/abhay-tf-part3/frontend`

## Cleanup

After collecting screenshots and testing, remove Part 3 resources:

```cmd
terraform destroy
```

Type `yes` to confirm. This does not delete the pre-existing ECR repositories or the S3 remote-state bucket because they are data sources / backend infrastructure.

Keep the S3 state bucket until the assignment and state files are no longer needed.
