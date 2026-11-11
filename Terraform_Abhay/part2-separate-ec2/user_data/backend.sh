#!/bin/bash
set -euxo pipefail

exec > >(tee -a /var/log/terraform-backend-user-data.log) 2>&1

echo "Starting Flask backend deployment..."

apt-get update -y
apt-get install -y git python3 python3-pip python3-venv

APP_DIR="/opt/docker-abhay"

git clone https://github.com/Mrdraculla/Docker_Abhay.git "$APP_DIR"

cd "$APP_DIR/backend"

python3 -m venv venv
./venv/bin/pip install --upgrade pip
./venv/bin/pip install -r requirements.txt
./venv/bin/pip install gunicorn

cat > /etc/systemd/system/terraform-flask.service <<'EOF'
[Unit]
Description=Terraform Flask Backend
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/opt/docker-abhay/backend
ExecStart=/opt/docker-abhay/backend/venv/bin/gunicorn --workers 2 --bind 0.0.0.0:5000 app:app
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable terraform-flask
systemctl restart terraform-flask

echo "Flask backend deployment completed."
