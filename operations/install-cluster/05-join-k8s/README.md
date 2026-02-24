# 加入 Kubernetes 集群

## 步骤描述
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

## 验证方法

- 查看 kubelet 服务的状态

  ```sh
  systemctl status kubelet
  ```

- 查看 kube-proxy 服务的状态

  ```sh
  systemctl status kube-proxy
  ```
