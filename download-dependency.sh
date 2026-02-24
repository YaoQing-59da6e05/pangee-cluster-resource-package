#!/usr/bin/env bash
set -e

SCRIPT_PATH=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

echo "重试次数 : $1"  # 重试次数
echo "CPU架构  : $2"  # CPU架构 （arm64 / amd64 / amd64,arm64）
echo "启用代理 : $3"  # 是否启用代理 （true / false）
echo "代理地址 : $4"  # 代理服务器地址

echo ""

DOWNLOAD_ARCH=$2
# 检查变量是否为空或未定义
if [ -z "$DOWNLOAD_ARCH" ]; then
    ARCH=$(uname -m)

    case "$ARCH" in
        x86_64|amd64|x64)
            DOWNLOAD_ARCH="amd64"
            ;;
        i386|i686|x86)
            echo "不兼容32位x86架构"
            exit 1
            ;;
        aarch64|arm64|armv8*)
            DOWNLOAD_ARCH="arm64"
            ;;
        armv7*)
            echo "不兼容32位ARM架构"
            exit 1
            ;;
        *)
            echo "不兼容的CPU架构: $ARCH"
            exit 1
            ;;
    esac
    echo "使用当前CPU架构作为 download_architecture: ${DOWNLOAD_ARCH}"
else
    echo "使用输入参数作为 download_architecture: ${DOWNLOAD_ARCH}"
fi

ENABLE_PROXY=$3
if [ -z "$ENABLE_PROXY" ]; then
  ENABLE_PROXY=false
fi

PROXY="$4"

echo "ENABLE_PROXY:$ENABLE_PROXY"
echo "PROXY:$PROXY"

cd $SCRIPT_DIR

ansible-playbook -vv \
  -i localhost \
  -e download_architecture=$DOWNLOAD_ARCH \
  -e enable_proxy_on_download=$ENABLE_PROXY \
  -e http_proxy=$PROXY \
  -e https_proxy=$PROXY \
  -e additional_no_proxy="10.0.0.0/8,127.0.0.1,::1,localhost,192.168.0.0/16" \
  -e default_retries=$1 \
  $SCRIPT_DIR/operations/download-dependency/01-download/playbook.yaml
