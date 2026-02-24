#!/bin/bash

DIR="$(cd "$(dirname "$0")" && pwd)"
rm -rf $DIR/yaml && mkdir -p $DIR/yaml

declare -A MAP_API_RESOURCES
API_RESOURCES=$(kubectl api-resources --no-headers --output=name --namespaced=true | xargs)
MAP_API_RESOURCES[$API_RESOURCES]="true"
API_RESOURCES=$(kubectl api-resources --no-headers --output=name --namespaced=false | xargs)
MAP_API_RESOURCES[$API_RESOURCES]="false"

# 忽略的api-resources
IGNORED_API_RESOURCES=(
  "events"                                                        # observables
  "events.events.k8s.io"                                          #
  "nodes"                                                         # strong correlation with current platform
  "nodes.metrics.k8s.io"                                          #
  "csinodes.storage.k8s.io"                                       # csinodes and nodes are created together, can be ignored
  "namespaces"                                                    # special handling required
  "pods"                                                          # often has affiliations with other resources
  "pods.metrics.k8s.io"                                           #
  "endpoints"                                                     # often has affiliations with other resources
  "endpointslices.discovery.k8s.io"                               #
  "replicasets.apps"                                              # often has affiliations with other resources
  "services"                                                      # special handling required
  "network-attachment-definitions.k8s.cni.cncf.io"                # deprecated in newer versions of k8s
  "controllerrevisions.apps"                                      # often has affiliations with other resources
  "serviceaccounts"                                               # Usually associated with namespace and deployments
  "clusterrolebindings.rbac.authorization.k8s.io"                 # special handling required
  "clusterroles.rbac.authorization.k8s.io"                        # special handling required
  "secrets"                                                       # Usually created by serviceaccount
  "componentstatuses"                                             # observables
  "priorityclasses.scheduling.k8s.io"                             # special handling required
  "apiservices.apiregistration.k8s.io"                            # custom definitions are not supported in the current version
  "podsecuritypolicies.policy"                                    # custom definitions are not supported in the current version
  "customresourcedefinitions.apiextensions.k8s.io"                # custom definitions are not supported in the current version
  "kubecontrollersconfigurations.crd.projectcalico.org"           # custom definitions are not supported in the current version
  "mutatingwebhookconfigurations.admissionregistration.k8s.io"    # custom definitions are not supported in the current version
  "validatingwebhookconfigurations.admissionregistration.k8s.io"  # custom definitions are not supported in the current version
  "flowschemas.flowcontrol.apiserver.k8s.io"                      # custom definitions are not supported in the current version
  "prioritylevelconfigurations.flowcontrol.apiserver.k8s.io"      # custom definitions are not supported in the current version
  "ipamhandles.crd.projectcalico.org"                             # custom definitions are not supported in the current version
  "ipamblocks.crd.projectcalico.org"                              # custom definitions are not supported in the current version
  "blockaffinities.crd.projectcalico.org"                         # custom definitions are not supported in the current version
)

# 忽略的属性
IGNORED_RESOURCE_PROPERTIES=(
  ".items[].metadata.annotations.\"kubectl.kubernetes.io/last-applied-configuration\""
  ".items[].metadata.creationTimestamp"
  ".items[].metadata.resourceVersion"
  ".items[].metadata.selfLink"
  ".items[].metadata.uid"
  ".items[].metadata.generation"
  ".items[].metadata.managedFields"
  ".items[].spec.claimRef"
  ".items[].spec.template.metadata.creationTimestamp"
  ".items[].status"
)
IGNORED_CLAUSE=$(IFS=","; echo "${IGNORED_RESOURCE_PROPERTIES[*]}")
IGNORED_CLAUSE="del(${IGNORED_CLAUSE})"

for API_RESOURCES in "${!MAP_API_RESOURCES[@]}"; do
  NAMESPACED=${MAP_API_RESOURCES[$API_RESOURCES]}
  for API_RESOURCE in $API_RESOURCES; do

    # 跳过忽略的api-resources
    FOUND=false
    for IGNORED in ${IGNORED_API_RESOURCES[@]}; do
      if [ $IGNORED == $API_RESOURCE ]; then
        FOUND=true
        break
      fi
    done
    if $FOUND; then
      echo "skip $API_RESOURCE..."
      continue
    fi

    # 设置NAMESPACE参数
    NAMESPACE_OPTS=""
    if [ "$NAMESPACED" == "true" ]; then
      NAMESPACE_OPTS="-A"
    fi

    # 跳过数量为0的资源类型
    COUNT=$(kubectl get $API_RESOURCE $NAMESPACE_OPTS 2>/dev/null | wc -l)
    if [ $COUNT -eq 0 ]; then
      echo "skip $API_RESOURCE..."
      continue
    fi

    # 导出资源类型
    echo "kubectl get $API_RESOURCE $NAMESPACE_OPTS -o yaml > $DIR/yaml/$API_RESOURCE.yaml"
    kubectl get $API_RESOURCE $NAMESPACE_OPTS -o yaml | yq eval $IGNORED_CLAUSE > $DIR/yaml/$API_RESOURCE.yaml
  done
done
