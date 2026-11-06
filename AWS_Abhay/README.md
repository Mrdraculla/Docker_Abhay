# AWS Deployment Assignment - Abhay Vishwakarma

## 1. Project Overview

This project demonstrates three deployment approaches for a full-stack application consisting of a Flask backend and an Express.js frontend using Amazon Web Services (AWS).

## 2. Technologies Used

- Python and Flask
- Node.js and Express.js
- Docker and Docker Compose
- Amazon EC2
- Amazon ECR
- Amazon ECS and AWS Fargate
- AWS Cloud Map
- Linux and Nginx

## 3. Project Structure

- `README.md` - Project overview and instructions
- `README.docx` - Original README document
- `documentation/` - Detailed AWS assignment report
- `screenshots/` - Deployment screenshots for all three tasks
- `source-code/backend/` - Flask backend application
- `source-code/frontend/` - Express frontend application
- `source-code/docker-compose.yml` - Docker Compose configuration

## 4. Task 1 - Single EC2 Deployment

The Flask backend and Express frontend were deployed on a single Amazon EC2 instance.

Implementation:
- Flask backend on port 5000.
- Express frontend on port 3000.
- Nginx configured as a reverse proxy.
- Public application access through HTTP port 80.

Application URL during testing: http://32.236.140.41/

## 5. Task 2 - Separate EC2 Deployment

The frontend and backend were deployed on separate EC2 instances.

Implementation:
- Express frontend hosted on the frontend EC2 instance.
- Flask backend hosted on a separate backend EC2 instance.
- Private IP communication configured between the instances.
- Security group rules restricted backend access to the frontend instance.
- Nginx configured for public frontend access.

Application URL during testing: http://32.236.140.41/

## 6. Task 3 - Docker, ECR and ECS Deployment

Both applications were containerized using Docker and deployed through Amazon ECS with AWS Fargate.

Implementation:
- Docker images created for the Flask backend and Express frontend.
- Images pushed to private Amazon ECR repositories.
- ECS cluster created.
- Separate ECS services deployed for frontend and backend.
- AWS Cloud Map configured for backend service discovery.
- Frontend connected to the backend using its private DNS name.

Application URL during testing: http://54.206.94.21:3000/

## 7. Testing and Verification

The following tests were successfully completed:

- Flask backend service availability.
- Express frontend availability.
- Frontend-to-backend communication.
- Nginx reverse proxy.
- Private IP communication between EC2 instances.
- Docker image creation and ECR image push.
- ECS service deployment.
- Cloud Map service discovery.
- End-to-end form submission.

## 8. Source Code

The source-code directory contains the Flask backend, Express frontend, Dockerfiles, dependency files and Docker Compose configuration.

## 9. Documentation and Screenshots

Detailed deployment documentation is available in:

`documentation/AWS_Assignment_Report.docx`

Screenshots for all three deployment tasks are available in their respective folders under `screenshots/`.

## 10. GitHub Repository

https://github.com/Mrdraculla/Docker_Abhay

## 11. Cost Management

AWS compute resources should be stopped or scaled down after assignment verification and submission to avoid unnecessary ongoing charges. ECR repositories and images are retained for reference.

## 12. Conclusion

This project demonstrates three approaches to deploying a full-stack application on AWS: single EC2 deployment, separate EC2 deployment, and containerized deployment using Docker, ECR and ECS.

All three deployments were tested, including frontend-to-backend communication and successful form submission.