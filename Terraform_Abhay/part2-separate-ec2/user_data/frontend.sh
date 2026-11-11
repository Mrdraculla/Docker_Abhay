#!/bin/bash
set -euxo pipefail

exec > >(tee -a /var/log/terraform-frontend-user-data.log) 2>&1

echo "Starting Express frontend deployment..."

apt-get update -y
apt-get install -y git nginx nodejs npm

APP_DIR="/opt/docker-abhay"

git clone https://github.com/Mrdraculla/Docker_Abhay.git "$APP_DIR"

cd "$APP_DIR/frontend"

npm ci --omit=dev

cat > /etc/systemd/system/terraform-express.service <<'EOF'
[Unit]
Description=Terraform Express Frontend
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/opt/docker-abhay/frontend
Environment=BACKEND_URL=http://${backend_private_ip}:5000
ExecStart=/usr/bin/node /opt/docker-abhay/frontend/server.js
Restart=always

[Install]
WantedBy=multi-user.target
EOF

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
systemctl enable terraform-express
systemctl enable nginx
systemctl restart terraform-express
systemctl restart nginx

echo "Express frontend deployment completed."
