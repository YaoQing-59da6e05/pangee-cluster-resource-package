# 从 Kubernetes 集群中删除节点

## 步骤描述
- 前置处理
  - 导出k8s资源(deployments、statefulsets)副本数
  - 调整k8s资源副本数为0
- 停止服务
  - 关闭及禁止kubelet、kube-proxy服务
  - 关闭calico-node容器
  - 如果是控制节点，则关闭及禁止kube-apiserver、kube-controller-manager、kube-scheduler服务以及停止kube-keepalived、kube-haproxy容器

## 验证方法

- 查看节点

  ```sh
  kubectl get nodes
  ```
