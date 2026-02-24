# 从 Kubernetes 集群中删除节点

## 步骤描述
- 禁止服务
  - 关闭及禁止kubelet、kube-proxy服务
  - 关闭calico-node容器
  - 如果是控制节点，则关闭及禁止kube-apiserver、kube-controller-manager、kube-scheduler服务以及删除kube-keepalived、kube-haproxy容器

## 验证方法

- 查看 kubelet 服务的状态

  ```sh
  systemctl status kubelet
  ```

- 查看 kube-proxy 服务的状态

  ```sh
  systemctl status kube-proxy
  ```
