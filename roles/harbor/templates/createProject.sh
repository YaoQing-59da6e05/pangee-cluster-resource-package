#!/bin/bash
set -euo pipefail

HARBOR_IP={{ hostvars[inventory_hostname]['ip'] }}
HARBOR_PORT={{ harbor_vip_port }}
HARBOR_USER="admin"
HARBOR_PASS="{{ harbor_admin_password }}"
PROJECTS="{{ harbor_projects }}"
for PROJECT in $(echo $PROJECTS | sed 's/,/ /g'); do
  curl -s http://$HARBOR_IP:$HARBOR_PORT/api/v2.0/projects \
       -u "$HARBOR_USER:$HARBOR_PASS" \
       -X POST \
       -H 'accept: application/json'  \
       -H 'Content-Type:application/json' \
       -H 'X-Resource-Name-In-Location: false'\
       -d '{
             "project_name": "'"${PROJECT}"'",
             "public": true
           }'
  if [ $? -ne 0 ]; then
    echo "Error: curl failed for project ${PROJECT}"
    exit 1
  fi
done
