#!/bin/bash
set -euxo pipefail
# backend_setup.sh - runs on backend EC2 (Amazon Linux 2023)
dnf update -y
dnf install -y docker git
systemctl enable --now docker
usermod -aG docker ec2-user || true
APP_DIR="/opt/much-to-do"
mkdir -p "$APP_DIR"
cd "$APP_DIR"
cat > .env <<EOF
PORT=${PORT:-8080}
MONGODB_URI=${MONGODB_URI}
EOF
chmod 600 .env
if [ -f Dockerfile ]; then
  docker build -t much-to-do-backend .
  docker rm -f much-to-do-backend || true
  docker run -d --name much-to-do-backend --restart always -p 8080:8080 --env-file .env much-to-do-backend
fi
for i in $(seq 1 30); do
  if curl -fs http://localhost:8080/health; then echo "Backend healthy"; break; fi
  sleep 5
done