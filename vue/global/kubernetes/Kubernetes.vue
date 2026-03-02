<i18n>
  en:
    kubernetes_label: Kubernetes Config
    kubernetes_description: Kubernetes Configuration
  
  zh:
    kubernetes_label: Kubernetes 参数
    kubernetes_description: 设置 Kubernetes 各组件所使用的参数
    kube_apiserver_vip_place_holder: Kubernetes virtual IP v4
    kube_apiserver_vip_cidr_place_holder: Kubernetes virtual CIDR
    kube_apiserver_vip_ipv6_place_holder: Kubernetes virtual IP v6
    kube_apiserver_vip_port_place_holder: haproxy代理apiserver安全端口，如果使用F5，F5需要提前配置好listen 1181 后端 6443
    k8s_ha_insecure_port_place_holder: haproxy代理apiserver非安全端口，如果使用F5，F5需要提前配置好listen 1180 后端 8080
    kube_apiserver_port_place_holder: K8S 安全端口，例如：6443
    kube_network_dualstack_enabled_place_holder: 是否支持IPv6/IPv4双栈
    kube_proxy_mode_place_holder: proxy mode
    kube_cluster_cidr_place_holder: Kubernetes pod CIDR
    kube_cluster_cidr_ipv6_place_holder: Kubernetes pod CIDR ipv6
    kube_service_cidr_place_holder: Kubernetes Service CIDR
    kube_service_cidr_ipv6_place_holder: Kubernetes Service CIDR ipv6
    kube_service_nodeport_range: 节点端口范围
    kube_service_nodeport_range_place_holder: 节点端口范围
    kube_proxy_metrics_port_place_holder: kube proxy 监控数据暴露端口
    kube_cluster_domain_place_holder: kubernetes 集群域名后缀
  </i18n>

<template>
  <ConfigSection v-model:enabled="enabled" :label="t('kubernetes_label')" :description="t('kubernetes_description')"
    disabled anti-freeze>
    <EditBool v-model="modelValue.all.children.target.vars.kube_network_dualstack_enabled"
      :prop="prop + '.kube_network_dualstack_enabled'" label="kube_dualstack_enabled"
      :placeholder="t('kube_network_dualstack_enabled_place_holder')">
    </EditBool>
    <EditNumber v-model="modelValue.all.children.target.vars.kube_apiserver_port" :prop="prop + '.kube_apiserver_port'"
      label="kube_apiserver_port" :placeholder="t('kube_apiserver_port_place_holder')">
    </EditNumber>
    <EditString v-model="modelValue.all.children.target.vars.kube_apiserver_vip" :prop="prop + '.kube_apiserver_vip'"
      label="kube_apiserver_vip" :placeholder="t('kube_apiserver_vip_place_holder')" required>
    </EditString>
    <EditString v-if="modelValue.all.children.target.vars.kube_network_dualstack_enabled"
      v-model="modelValue.all.children.target.vars.kube_apiserver_vip_ipv6" :prop="prop + '.kube_apiserver_vip_ipv6'"
      label="kube_apiserver_vip_ipv6" :placeholder="t('kube_apiserver_vip_ipv6_place_holder')" required>
    </EditString>
    <EditNumber v-model="modelValue.all.children.target.vars.kube_apiserver_vip_port"
      :prop="prop + '.kube_apiserver_vip_port'" label="kube_apiserver_vip_port"
      :placeholder="t('kube_apiserver_vip_port_place_holder')">
    </EditNumber>
    <EditRadio v-model="modelValue.all.children.target.children.k8s_cluster.vars.kube_proxy_mode" :options="options"
      prop="all.children.target.children.k8s_cluster.vars.kube_proxy_mode" label="kube_proxy_mode"
      :placeholder="t('kube_proxy_mode_place_holder')">
    </EditRadio>
    <EditString v-model="modelValue.all.children.target.children.k8s_cluster.vars.kube_cluster_cidr"
      prop="modelValue.all.children.target.children.k8s_cluster.vars.kube_cluster_cidr" label="kube_cluster_cidr"
      :placeholder="t('kube_cluster_cidr_place_holder')">
    </EditString>
    <EditString v-if="modelValue.all.children.target.vars.kube_network_dualstack_enabled"
      v-model="modelValue.all.children.target.children.k8s_cluster.vars.kube_cluster_cidr_ipv6"
      prop="modelValue.all.children.target.children.k8s_cluster.vars.kube_cluster_cidr_ipv6"
      label="kube_cluster_cidr_ipv6" :placeholder="t('kube_cluster_cidr_ipv6_place_holder')">
    </EditString>
    <EditString v-model="modelValue.all.children.target.children.k8s_cluster.vars.kube_service_cidr"
      prop="modelValue.all.children.target.children.k8s_cluster.vars.kube_service_cidr" label="kube_service_cidr"
      :placeholder="t('kube_service_cidr_place_holder')">
    </EditString>
    <EditString v-if="modelValue.all.children.target.vars.kube_network_dualstack_enabled"
      v-model="modelValue.all.children.target.children.k8s_cluster.vars.kube_service_cidr_ipv6"
      prop="modelValue.all.children.target.children.k8s_cluster.vars.kube_service_cidr_ipv6"
      label="kube_service_cidr_ipv6" :placeholder="t('kube_service_cidr_ipv6_place_holder')">
    </EditString>
    <EditString v-model="modelValue.all.children.target.children.k8s_cluster.vars.kube_service_nodeport_range"
      prop="modelValue.all.children.target.children.k8s_cluster.vars.kube_service_nodeport_range"
      label="kube_service_nodeport_range" :placeholder="t('kube_service_nodeport_range_place_holder')">
    </EditString>
    <EditNumber v-model="modelValue.all.children.target.children.k8s_cluster.vars.kube_proxy_metrics_port"
      prop="modelValue.all.children.target.children.k8s_cluster.vars.kube_proxy_metrics_port"
      label="kube_proxy_metrics_port" :placeholder="t('kube_proxy_metrics_port_place_holder')">
    </EditNumber>
    <EditString v-model="modelValue.all.children.target.children.k8s_cluster.vars.kube_cluster_domain"
      prop="modelValue.all.children.target.children.k8s_cluster.vars.kube_cluster_domain" label="kube_cluster_domain"
      :placeholder="t('kube_cluster_domain_place_holder')">
    </EditString>
  </ConfigSection>
</template>

<script lang="ts" setup>
import { inject, ref } from "vue"

const t = inject("t");

const modelValue = defineModel<any>();

const enabled = ref(true)

defineProps<{
  resourcePackage: any;
}>()


const prop = 'all.children.target.vars'

const options = [
  {
    label: 'iptables',
    value: 'iptables'
  },
  {
    label: 'ipvs',
    value: 'ipvs'
  }
]

</script>