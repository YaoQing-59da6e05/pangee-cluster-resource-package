<i18n>
en:
  harbor_label: Harbor Params
  harbor_description: Harbor parameters.

zh:
  harbor_label: Harbor 配置
  harbor_description: Harbor 参数设置。如果不安装 harbor，请关闭此项配置
  harbor_vip_place_holder: Harbor virtual IP v4
  harbor_vip_ipv6_place_holder: Harbor virtual IP v6
</i18n>

<template>
  <ConfigSection v-model:enabled="enabled" :label="t('harbor_label')" :description="t('harbor_description')"
    anti-freeze>
    <EditString v-model="modelValue.all.children.target.children.harbor.vars.harbor_vip" :prop="prop + '.harbor_vip'"
      required label="harbor_vip" :placeholder="t('harbor_vip_place_holder')">
    </EditString>
    <EditString
      v-if="modelValue.all.children.target.vars.kube_network_dualstack_enabled"
      v-model="modelValue.all.children.target.children.harbor.vars.harbor_vip_ipv6" :prop="prop + '.harbor_vip_ipv6'"
      required label="harbor_vip_ipv6" :placeholder="t('harbor_vip_ipv6_place_holder')">
    </EditString>
    <EditNumber v-model="modelValue.all.children.target.children.harbor.vars.harbor_vip_port"
      :prop="prop + '.harbor_vip_port'" label="harbor_vip_port">
    </EditNumber>
    <EditNumber v-model="modelValue.all.children.target.children.harbor.vars.harbor_metrics_port"
      :prop="prop + '.harbor_metrics_port'" label="harbor_metrics_port">
    </EditNumber>
  </ConfigSection>
</template>

<script lang="ts" setup>
import { inject, computed } from "vue";

const t = inject("t");

const modelValue = defineModel<any>();

const enabled = computed({
  get() {
    return modelValue.value.all.children.target.children.harbor.vars.harbor_vip !== undefined
  },
  set(v: boolean) {
    if (v) {
      modelValue.value.all.children.target.children.harbor.vars.harbor_vip = null
    } else {
      delete modelValue.value.all.children.target.children.harbor.vars.harbor_vip
    }
  }
});

defineProps<{
  resourcePackage: any;
}>()


const prop = 'all.children.target.children.harbor.vars'

</script>