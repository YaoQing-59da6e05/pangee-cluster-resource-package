nerdctl run \
    -d \
    --name kube-keepalived \
    --restart=always \
    --cap-add=NET_ADMIN \
    --cap-add=NET_BROADCAST \
    --cap-add=NET_RAW \
    --net=host \
    -v ${PWD}/keepalived/keepalived.conf:/container/service/keepalived/assets/keepalived.conf \
    -v ${PWD}/keepalived/check.sh:/opt/check.sh \
    --detach \
    {{ image_base_keepalived }} \
    --copy-service
