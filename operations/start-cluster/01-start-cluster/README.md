# 从 Kubernetes 集群中删除节点

## 步骤描述
- 启动服务
  - 启动及允许kubelet、kube-proxy服务
  - 如果是控制节点，则启动及允许kube-apiserver、kube-controller-manager、kube-scheduler服务以及启动kube-keepalived、kube-haproxy容器
- 后置处理
  - 调整k8s资源副本数为原始数量

## 验证方法

- 查看节点

  ```sh
  kubectl get nodes
  ```
