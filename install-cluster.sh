#!/usr/bin/env bash
set -e

#ansible-playbook -vv -i inventory.yaml operations/download-dependency/01-download/playbook.yaml

ansible-playbook -vv -i inventory.yaml operations/install-cluster/01-init-os/playbook.yaml
ansible-playbook -vv -i inventory.yaml operations/install-cluster/02-install-cri/playbook.yaml
ansible-playbook -vv -i inventory.yaml operations/install-cluster/03-install-etcd/playbook.yaml
ansible-playbook -vv -i inventory.yaml operations/install-cluster/04-install-k8s/playbook.yaml
ansible-playbook -vv -i inventory.yaml operations/install-cluster/05-join-k8s/playbook.yaml

#ansible-playbook -vv -i inventory.yaml operations/add-node/01-init-os/playbook.yaml
#ansible-playbook -vv -i inventory.yaml operations/add-node/02-install-cri/playbook.yaml
#ansible-playbook -vv -i inventory.yaml operations/add-node/03-join-k8s/playbook.yaml

#ansible-playbook -vv -i inventory.yaml operations/delete-node/01-remove-from-cluster/playbook.yaml
#ansible-playbook -vv -i inventory.yaml operations/delete-node/02-reset-node/playbook.yaml

#ansible-playbook -vv -i inventory.yaml operations/install-harbor/01-install-harbor/playbook.yaml

#ansible-playbook -vv -i inventory.yaml operations/stop-cluster/01-stop-cluster/playbook.yaml
#ansible-playbook -vv -i inventory.yaml operations/start-cluster/01-start-cluster/playbook.yaml

#ansible-playbook -vv -i inventory.yaml operations/export-cluster/01-export-cluster/playbook.yaml
#ansible-playbook -vv -i inventory.yaml operations/import-cluster/01-import-cluster/playbook.yaml