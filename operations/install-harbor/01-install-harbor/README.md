# 安装harbor

## 步骤描述
- 初始化主机
  - 判断是否复用kube_control_plane、kube_node主机组，如复用主机说明已经执行过初始化操作系统及已安装cri，否则执行初始化操作

- 安装docker-compose
  - 复制可执行文件docker、dockerd、docker-init、docker-proxy、docker-compose
  - 复制服务文件docker.service、docker.socket
  - 渲染配置文件daemon.json
  - 创建用户组docker
  - 允许并启动docker服务

- 安装keepalived
  - 复制并导入镜像{{ cache_dir }}/keepalived.tar.gz
  - 复制check.sh、keepalived.conf、run-keepalived.sh
  - 删除已运行的harbor-keepalived容器并重新启动

- 安装harbor
  - 在ansible主机/tmp生成private_key.pem(pkcs1)及secretkey
  - 复制并导入harbor相关镜像
  - 复制harbor安装相关文件common.sh、install.sh、prepare、LICENSE、harborProject.sh、private_key.pem、secretkey 
  - 渲染模板harbor.yml.tmpl、harbor.service
  - 删除存在的harbor容器及安装目录
  - 运行安装脚本
  - 允许并启动harbor服务

- 重启containerd及harbor
  - 渲染模板config.toml
  - 替换安装生成的private_key.pem及secretkey
  - 启动containerd、kubelet及harbor服务

- 配置复制关系
  - 复制harborMasterSlave.sh
  - 运行harborMasterSlave.sh创建复制关系

## 验证方法

- 查看harbor运行容器

  ```sh
  docker ps -a | grep goharbor
  ```
