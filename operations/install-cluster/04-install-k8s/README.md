# 安装 Kubernetes 集群

安装k8s控制面及节点组件、部署apiserver高可用访问VIP、安装calico网络插件及coredns

## 步骤描述
- 安装 kube-apiserver
  - 创建{{ kube_ssl_dir }}、{{ root_dir }}/log/kubernetes、$HOME/.kube目录
  - 复制可执行文件kube-apiserver
  - 复制证书文件apiserver.crt、apiserver.key、ca.crt、ca.key、client.crt、client.key、etcd_client.crt、etcd_client.key、front-proxy-ca.crt、front-proxy-ca.key、front-proxy-client.crt、front-proxy-client.key、sa.key、sa.pub
  - 渲染模板至{{ kube_config_dir }}/apiserver、{{ kube_config_dir }}/kubeconfig、$HOME/.kube/config、{{ root_dir }}/etc/systemd/system/kube-apiserver.service
  - 允许并重启kube-apiserver服务
  - 检查kube-apiserver服务状态

- 安装 kube-controller-manager
  - 复制可执行文件kube-controller-manager
  - 渲染模板至{{ kube_config_dir }}/controller-manager、{{ root_dir }}/etc/systemd/system/kube-controller-manager.service
  - 允许并重启kube-controller-manager服务
  - 检查kube-controller-manager服务状态

- 安装 kube-scheduler
  - 复制可执行文件kube-scheduler
  - 渲染模板至{{ kube_config_dir }}/scheduler、{{ root_dir }}/etc/systemd/system/kube-scheduler.service
  - 允许并重启kube-scheduler服务
  - 检查kube-scheduler服务状态

- 安装 kube-ha
  - 创建kube-ha/keepalived及kube-ha/haproxy目录
  - 复制keepalived及haproxy镜像
  - 渲染模板keepalived.conf、check.sh、haproxy.cfg、run-haproxy.sh、run-keepalived.sh
  - 加载镜像keepalived及haproxy
  - 停止及删除容器kube-keepalived及kube-haproxy
  - 启动容器kube-keepalived及kube-haproxy

- 安装 kube-node
  - 创建{{ kube_ssl_dir }}、/var/run/kubernetes、{{ kube_dir }}目录
  - 复制可执行文件kubelet、kube-proxy
  - 复制服务配置文件kubelet.service、kube-proxy.service
  - 复制证书文件ca.crt、client.key、client.crt
  - 复制镜像文件calico-cni、calico-node、calico-kube-controllers、coredns
  - 渲染模板至{{ kube_config_dir }}/kubelet、{{ kube_config_dir }}/proxy、{{ kube_config_dir }}/kubelet.config、{{ kube_config_dir }}/kubeconfig
  - 删除cni目录/etc/cni/net.d
  - 加载镜像calico-cni、calico-node、calico-kube-controllers、coredns
  - 重启containerd服务
  - 允许并重启kubelet及kube-proxy服务
  - 检查kubelet及kube-proxy服务状态

- 节点标签
  - 设置控制面节点标签k8s-app=coredns
  - 设置控制面节点标签node-role.kubernetes.io/control-plane=[NoSchedule]

- 安装 calico
  - 创建/etc/NetworkManager/conf.d目录
  - 渲染模板至/etc/NetworkManager/conf.d/calico.conf
  - 复制calico-3.23.2-ipv6-vxlan.yaml及calico-bgpport.yaml
  - kubectl删除并应用calico-3.23.2-ipv6-vxlan.yaml及calico-bgpport.yaml
  - 检查calico pod状态

- 安装 coredns
  - 设置变量etcd_servers及coredns_ip/coredns_ipv6
  - 渲染模板coredns-v1.7.0-with-etcd.yaml
  - 创建configmap etcd-cert
  - kubectl删除并应用coredns-v1.7.0-with-etcd.yaml
  - 检查coredns pod状态

## 验证方法
- 查看 kube-apiserver 服务的状态

  ```sh
  systemctl status kube-apiserver
  ```

- 查看 kube-controller-manager 服务的状态

  ```sh
  systemctl status kube-controller-manager
  ```

- 查看 kube-scheduler 服务的状态

  ```sh
  systemctl status kube-scheduler
  ```

- 查看 kube-keepalived 服务的状态

  ```sh
  nerdctl ps -a | grep kube-keepalived
  ```

- 查看 kube-haproxy 服务的状态

  ```sh
  nerdctl ps -a | grep kube-haproxy
  ```

- 查看 kubelet 服务的状态

  ```sh
  systemctl status kubelet
  ```

- 查看 kube-proxy 服务的状态

  ```sh
  systemctl status kube-proxy
  ```

- 查看标签

  ```sh
  kubectl get node --show-labels
  ```

- 查看 calico 服务的状态

  ```sh
  kubectl get pods -n kube-system -o wide | grep calico
  ```

- 查看 coredns 服务的状态

  ```sh
  kubectl get pods -n kube-system -o wide | grep coredns
  ```
