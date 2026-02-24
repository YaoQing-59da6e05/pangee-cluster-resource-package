# 初始化操作系统

对操作系统初始化设置，以便使 kubernetes 能正常运行或者获得最佳性能。

## 步骤描述

- 初始化操作系统参数
  - 设置主机名（inventory_hostname）
  - 安装依赖包 nfs-utils、conntrack、iptables
  - 允许并重启 nfs-server 服务
  - 加载 br_netfilter 模块
  - 备份/etc/sysctl.conf
  - 设置 kernel.shmmax、kernel.shmall、kernel.shmmni
  - 设置 kernel.pid_max
  - 设置 net.ipv4.neigh.default.gc_thresh1/2/3
  - 设置 kernel.sem
  - 设置 fs.aio-max-nr、fs.file-max
  - 设置 net.ipv4.ip_local_port_range（33000 65500）
  - 设置 net.core.rmem_default、net.core.rmem_max、net.core.wmem_default、net.core.wmem_max
  - 设置 net.ipv4.ip_forward
  - 设置 net.bridge.bridge-nf-call-iptables、net.bridge.bridge-nf-call-ip6tables
  - 备份/etc/security/limits.conf
  - selinux 设为宽容模式，并将/etc/sysconfig/selinux、/etc/selinux/config 中的 SELINUX 模式替换为 disabled
  - 关闭并禁止 firewalld 服务
  - 关闭并禁止交换分区
  - 设置/etc/security/limits.conf 中 nofile、nproc、stack、memlock 参数
  - 设置/etc/systemd/system.conf 中 DefaultLimitNOFILE、DefaultLimitNPROC、DefaultLimitMEMLOCK、DefaultLimitCORE 参数

- 安装 chrony 服务
  - 安装依赖包 chrony
  - 渲染模板至/etc/chrony/chrony.conf
  - 允许并重启 chronyd

## 验证方法

- 查看 sysctl 的设置

- 查看 chrony 服务的配置

  ```sh
  # !/bin/bash
  cat /etc/chrony/chrony.conf
  ```

- 查看 chrony 服务的状态

  ```sh
  systemctl status chronyd
  ```
