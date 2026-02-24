#!/usr/bin/env bash
set -e

SCRIPT_PATH=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

ansible-playbook -vv -i $SCRIPT_DIR/inventory.yaml $SCRIPT_DIR/operations/create-package/01-create-package/playbook.yaml