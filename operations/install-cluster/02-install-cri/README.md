# 安装容器运行时

## 步骤描述
- 创建容器运行时相关目录/etc/containerd
- 复制容器运行时相关文件containerd.service/containerd/containerd-shim/containerd-shim-runc-v2/ctr/runc/nerdctl/pause镜像
- 渲染模板至/etc/containerd/config.toml
- 允许并重启containerd服务
- 加载pause镜像
- 检查containerd服务状态

## 验证方法
- 查看 containerd 服务的配置

  ```sh
  # !/bin/bash
  cat /etc/containerd/config.toml
  ```

- 查看 containerd 服务的状态

  ```sh
  systemctl status containerd
  ```
