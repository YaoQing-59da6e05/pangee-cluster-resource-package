#!/bin/bash
# 主从同步

set -eo pipefail

HARBOR1_URL=$1
HARBOR1_USER=$2
HARBOR1_PASS="$3"

HARBOR2_URL=$4
HARBOR2_USER=$5
HARBOR2_PASS="$6"

createReplication() {
    MASTER_HARBOR_URL=$1
    MASTER_HARBOR_USER=$2
    MASTER_HARBOR_PASS=$3
    
    SLAVE_HARBOR_URL=$4
    SLAVE_HARBOR_USER=$5
    SLAVE_HARBOR_PASS=$6

    curl -s "$MASTER_HARBOR_URL/api/v2.0/registries" \
        -u "$MASTER_HARBOR_USER:$MASTER_HARBOR_PASS" \
        -X POST \
        -H 'Content-Type:application/json' \
        -d '{
            "credential":{
                "access_key":"'$SLAVE_HARBOR_USER'",
                "access_secret":"'$SLAVE_HARBOR_PASS'",
                "type":"basic"
            },
            "description":"",
            "insecure":true,
            "name":"harbor-slave",
            "type":"harbor",
            "url": "http://'$SLAVE_HARBOR_URL'"
       }'
}

getReplication() {
    MASTER_HARBOR_URL=$1
    MASTER_HARBOR_USER=$2
    MASTER_HARBOR_PASS=$3
    curl -s "http://$MASTER_HARBOR_URL/api/v2.0/registries" \
        -u "$MASTER_HARBOR_USER:$MASTER_HARBOR_PASS" \
        -X GET \
        -H 'Content-Type:application/json'
}

createReplicationPolicy() {
    MASTER_HARBOR_URL=$1
    MASTER_HARBOR_USER=$2
    MASTER_HARBOR_PASS=$3
    
    SLAVE_HARBOR_URL=$4
    SLAVE_HARBOR_USER=$5
    SLAVE_HARBOR_PASS=$6
    
    ID=$7
    TYPE=$8
    
    curl -s "http://$MASTER_HARBOR_URL/api/v2.0/replication/policies" \
        -u "$MASTER_HARBOR_USER:$MASTER_HARBOR_PASS" \
        -X POST \
        -H 'Content-Type:application/json' \
        -d '{
            "deletion": true,
            "dest_registry": {
                "credential": {
                    "access_key": "'$SLAVE_HARBOR_USER'",
                    "type": "basic"
                },
                "id": '"$ID"',
                "name": "slave",
                "status": "healthy",
                "type": "harbor",
                 "url": "http://'$SLAVE_HARBOR_URL'"
            },
            "enabled": true,
            "name": "harbor-slave-sync",
            "override": true,
            "trigger": {
                "type": "'$TYPE'"
            }
        }'
} 

getReplicationPolicy() {
    HARBOR_URL=$1
    HARBOR_USER=$2
    HARBOR_PASS=$3
    curl -s "http://$HARBOR_URL/api/v2.0/replication/policies" \
        -u "$HARBOR_USER:$HARBOR_PASS" \
        -X GET \
        -H 'Content-Type:application/json'
}

executeReplication() {
    HARBOR_URL=$1
    HARBOR_USER=$2
    HARBOR_PASS=$3
    ID=$4
    curl -s "http://$HARBOR_URL/api/v2.0/replication/executions" \
        -u "$HARBOR_USER:$HARBOR_PASS" \
        -H 'Content-Type: application/json' \
        -H 'Accept: application/json' \
        -d '{"policy_id": '"$ID"'}'
}

queryReplication() {
    HARBOR_URL=$1
    HARBOR_USER=$2
    HARBOR_PASS=$3
    ID=$4
    curl -s "http://$HARBOR_URL/api/v2.0/replication/executions?page=1&page_size=100&policy_id=$ID" \
        -u "$HARBOR_USER:$HARBOR_PASS" \
        -H 'Content-Type: application/json' \
        -H 'Accept: application/json'
}

DIR=$(dirname $0)
createReplication $HARBOR1_URL $HARBOR1_USER $HARBOR1_PASS $HARBOR2_URL $HARBOR2_USER $HARBOR2_PASS
ID=$(getReplication $HARBOR1_URL $HARBOR1_USER $HARBOR1_PASS | $DIR/yq '.[] .id')
createReplicationPolicy $HARBOR1_URL $HARBOR1_USER $HARBOR1_PASS $HARBOR2_URL $HARBOR2_USER $HARBOR2_PASS $ID "event_based"
POLICY_ID=$(getReplicationPolicy $HARBOR1_URL $HARBOR1_USER $HARBOR1_PASS | $DIR/yq '.[] .id')
executeReplication $HARBOR1_URL $HARBOR1_USER $HARBOR1_PASS $POLICY_ID
sleep 1
queryReplication $HARBOR1_URL $HARBOR1_USER $HARBOR1_PASS $POLICY_ID
