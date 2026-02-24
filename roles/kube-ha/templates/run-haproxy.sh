nerdctl run -d --name kube-haproxy --net=host --restart=always -v ${PWD}/haproxy/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro {{ image_base_haproxy }}
