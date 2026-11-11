#!/bin/bash
set -euxo pipefail

exec > >(tee -a /var/log/terraform-user-data.log) 2>&1

echo "Starting Flask and Express deployment..."

apt-get update -y
apt-get install -y git python3 python3-pip python3-venv nginx nodejs npm

APP_DIR="/opt/docker-abhay"

# Clone application source
git clone https://github.com/Mrdraculla/Docker_Abhay.git "$APP_DIR"

# Configure Flask backend
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
ExecStart=/opt/docker-abhay/backend/venv/bin/gunicorn --workers 2 --bind 127.0.0.1:5000 app:app
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Configure Express frontend
cd "$APP_DIR/frontend"

npm ci --omit=dev

cat > /etc/systemd/system/terraform-express.service <<'EOF'
[Unit]
Description=Terraform Express Frontend
After=network.target terraform-flask.service

[Service]
User=ubuntu
WorkingDirectory=/opt/docker-abhay/frontend
Environment=BACKEND_URL=http://127.0.0.1:5000
ExecStart=/usr/bin/node /opt/docker-abhay/frontend/server.js
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Configure Nginx reverse proxy
cat > /etc/nginx/sites-available/terraform-app <<'EOF'
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
EOF

rm -f /etc/nginx/sites-enabled/default
ln -sf /etc/nginx/sites-available/terraform-app /etc/nginx/sites-enabled/terraform-app

nginx -t

systemctl daemon-reload
systemctl enable terraform-flask
systemctl enable terraform-express
systemctl enable nginx

systemctl restart terraform-flask
systemctl restart terraform-express
systemctl restart nginx

echo "Flask and Express deployment completed."
