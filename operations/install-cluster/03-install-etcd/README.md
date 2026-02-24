# 安装 ETCD

创建安装etcd及kubernetes需要的证书文件，以及安装etcd服务

## 步骤描述
- 创建证书
  - 渲染创建证书需要的cnf文件master_ssl.cnf、etcd_ssl.cnf、front_proxy_ssl.cnf
  - 创建自签名根证书ca.key、ca.crt
  - 创建etcd服务端证书etcd_server.key、etcd_server.csr、etcd_server.crt
  - 创建etcd客户端证书etcd_client.key、etcd_client.csr、etcd_client.crt
  - 创建apiserver服务端证书apiserver.key、apiserver.csr、apiserver.crt
  - 创建apiserver客户端证书client.key、client.csr、client.crt
  - 创建用于ServiceAccount令牌签名密钥sa.key、sa.pub
  - 创建反向代理自签名根证书front-proxy-ca.key、front-proxy-ca.crt
  - 创建反向代理客户端证书front-proxy-client.key、front-proxy-client.csr、front-proxy-client.crt

- 安装 ETCD
  - 创建{{ root_dir }}/etc/etcd、{{ etcd_data_dir }}、{{ kube_ssl_dir }}相关目录
  - 复制可执行文件etcd、etcdctl
  - 复制证书文件ca.crt、ca.key、etcd_server.crt、etcd_server.key、etcd_client.crt、etcd_client.key至{{ kube_ssl_dir }}
  - 渲染模板至{{ root_dir }}/etc/etcd/etcd.conf、{{ root_dir }}/etc/systemd/system/etcd.service
  - 允许并重启etcd服务
  - 检查etcd服务状态

## 验证方法
- 查看 etcd 服务的状态

  ```sh
  systemctl status etcd
  ```
