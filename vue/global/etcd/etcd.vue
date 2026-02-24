<i18n>
en:
  etcd_label: Etcd Setup
  etcd_description: Etcd Setup, used to set some etcd variables.

zh:
  etcd_label: ETCD
  etcd_description: ETCD 参数设置。
  etcd_client_port_place_holder: ETCD 客户访问端口
  etcd_peer_port_place_holder: ETCD 节点互联端口
</i18n>

<template>
  <ConfigSection v-model:enabled="enabled" :label="t('etcd_label')" :description="t('etcd_description')" disabled
    anti-freeze>
    <EditNumber v-model="modelValue.all.children.target.children.etcd.vars.etcd_client_port"
      :prop="prop + '.etcd_client_port'" label="etcd_client_port" :placeholder="t('etcd_client_port_place_holder')">
    </EditNumber>
    <EditNumber v-model="modelValue.all.children.target.children.etcd.vars.etcd_peer_port"
      :prop="prop + '.etcd_peer_port'" label="etcd_peer_port" :placeholder="t('etcd_peer_port_place_holder')">
    </EditNumber>
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

</script>