# Jenkins CI/CD Automation on AWS

## Project Overview

This project demonstrates Continuous Integration and Continuous Deployment (CI/CD) using Jenkins, GitHub, and AWS EC2.

It deploys two applications:
- **Flask Backend:** Python application running on port 5000.
- **Express Frontend:** Node.js application running on port 3000.

Jenkins automatically checks out the latest source code from GitHub, installs dependencies, performs basic validation, and deploys each application when a GitHub push event triggers the configured webhook.

## Architecture

- AWS EC2 instance running Ubuntu 24.04.
- Jenkins for CI/CD automation.
- GitHub repository for source-code management.
- GitHub webhook for automatic pipeline triggering.
- Nginx as a reverse proxy for the Express frontend.
- Flask backend managed by systemd.
- Express frontend managed by systemd.

## Project Structure

```text
Jenkins_CICD_Abhay/
├── flask/
│   ├── app.py
│   ├── requirements.txt
│   ├── Jenkinsfile
│   └── Dockerfile
├── express/
│   ├── server.js
│   ├── package.json
│   ├── package-lock.json
│   ├── public/
│   └── Jenkinsfile
├── screenshots/
├── documentation/
└── README.md
```

## Jenkins Pipelines

Two independent Jenkins pipelines are configured.

### 1. Flask-CI-CD

Pipeline stages:
1. Checkout source code from GitHub.
2. Install Python dependencies and Gunicorn.
3. Validate Python application syntax.
4. Deploy application files.
5. Restart the Flask systemd service.

### 2. Express-CI-CD

Pipeline stages:
1. Checkout source code from GitHub.
2. Install Node.js dependencies.
3. Validate JavaScript syntax.
4. Deploy application files.
5. Restart the Express systemd service.

## GitHub Webhook

A GitHub webhook is configured to send push events to Jenkins.

Webhook endpoint:

`http://<EC2-PUBLIC-IP>:8080/github-webhook/`

Event subscription: Push events.

A successful HTTP 200 webhook delivery was verified.

## Application Deployment

- Flask application: `127.0.0.1:5000`
- Express application: `127.0.0.1:3000`
- Public application access: `http://<EC2-PUBLIC-IP>/`
- Nginx listens on port 80 and forwards requests to Express.

Both applications are managed using systemd services:
- `flask-app`
- `express-app`

## Verification

The following tests were completed successfully:

- Flask Jenkins pipeline completed successfully.
- Express Jenkins pipeline completed successfully.
- GitHub webhook delivery returned HTTP 200.
- Both application services were verified.
- Public frontend was accessible.
- Form submission successfully reached the backend.

## Technologies Used

- AWS EC2
- Ubuntu 24.04
- Jenkins
- Git and GitHub
- Python 3
- Flask
- Gunicorn
- Node.js
- Express.js
- Nginx
- Linux systemd
- GitHub Webhooks

## GitHub Repository

Repository: https://github.com/Mrdraculla/Docker_Abhay

Flask source: `Jenkins_CICD_Abhay/flask/`

Express source: `Jenkins_CICD_Abhay/express/`

## Deployment Environment

- Cloud Provider: Amazon Web Services
- Compute: Amazon EC2
- CI/CD: Jenkins
- Backend: Python and Flask
- Frontend: Node.js and Express
- Version Control: Git and GitHub

## Screenshots and Documentation

Deployment screenshots, Jenkins pipeline logs, webhook evidence, and command explanations are maintained in the screenshots and documentation folders.

## Final Verification

- Flask Jenkins pipeline: **SUCCESS**
- Express Jenkins pipeline: **SUCCESS**
- GitHub webhook: Successfully tested with HTTP 200 response.
- Public web application: Successfully accessed.
- Frontend form submission: Successful.

## Important Notes

- AWS resources should be stopped or terminated after assignment verification to avoid unnecessary charges.
- Do not commit AWS credentials, private keys, Jenkins passwords, webhook secrets, or other sensitive information to GitHub.
- The public EC2 IP may change if the instance is stopped and restarted unless an Elastic IP is assigned.