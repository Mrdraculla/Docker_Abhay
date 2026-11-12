

\# Jenkins CI/CD Deployment - Flask and Express



\## Project Overview



This project deploys a Flask backend and an Express.js frontend on a single Amazon EC2 instance. Jenkins automates application deployment whenever code is pushed to GitHub.



\## Project Structure



```text

Jenkins\_CICD\_Abhay/

├── flask/

│   ├── app.py

│   ├── requirements.txt

│   └── Jenkinsfile

├── express/

│   ├── public/

│   ├── server.js

│   ├── package.json

│   ├── package-lock.json

│   └── Jenkinsfile

├── screenshots/

├── documentation/

└── README.md

```



\## Architecture



GitHub Repositories

&#x20;      |

&#x20;      | Push / Webhook

&#x20;      v

&#x20;    Jenkins

&#x20;      |

&#x20;      +------ Flask Pipeline

&#x20;      |          |

&#x20;      |          v

&#x20;      |      Flask Backend

&#x20;      |      Port 5000

&#x20;      |

&#x20;      +------ Express Pipeline

&#x20;                 |

&#x20;                 v

&#x20;            Express Frontend

&#x20;              Port 3000



Both applications run on the same EC2 instance.



\## Application Details



\### Flask Backend

\- Framework: Flask

\- Entry point: app.py

\- Port: 5000

\- Dependencies: requirements.txt

\- API endpoint: POST /api/submit



\### Express Frontend

\- Framework: Express.js

\- Entry point: server.js

\- Port: 3000

\- Dependencies: package.json

\- Communicates with Flask through BACKEND\_URL.



\## CI/CD Pipeline



Two independent Jenkins pipelines are configured:



1\. Flask Pipeline

&#x20;  - Checkout source code

&#x20;  - Install Python dependencies

&#x20;  - Run syntax validation

&#x20;  - Deploy application

&#x20;  - Restart Flask service



2\. Express Pipeline

&#x20;  - Checkout source code

&#x20;  - Install Node.js dependencies

&#x20;  - Run syntax validation

&#x20;  - Deploy application

&#x20;  - Restart Express service



GitHub webhooks will trigger the pipelines when code is pushed.



\## GitHub Repository



Repository: https://github.com/Mrdraculla/Docker\_Abhay



Flask source: Jenkins\_CICD\_Abhay/flask/



Express source: Jenkins\_CICD\_Abhay/express/



\## Deployment Environment



\- Cloud Provider: Amazon Web Services

\- Compute: Amazon EC2

\- CI/CD: Jenkins

\- Backend: Python and Flask

\- Frontend: Node.js and Express

\- Version Control: Git and GitHub



\## Screenshots and Documentation



Deployment screenshots, Jenkins pipeline logs, webhook evidence, and command explanations are maintained in the screenshots and documentation folders.



\## Final Verification

Webhook testing successful

The final deployment URLs, EC2 details, successful pipeline builds, and webhook test results will be added after deployment.



