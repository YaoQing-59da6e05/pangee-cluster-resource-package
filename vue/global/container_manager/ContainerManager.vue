<i18n>
en:
  cm_label: ContainerManager
  cm_description: Container Manager
  cri_docker_root_size_place_holder: docker root dir size
zh:
  cm_label: 容器引擎
  cm_description: 设置集群范围内所有节点使用的容器引擎相关参数
  cri_docker_root_size_place_holder: docker 数据盘大小
</i18n>

<template>
  <ConfigSection v-model:enabled="enabled" :label="t('cm_label')" :description="t('cm_description')" disabled
    anti-freeze>
    <ContainerManagerRegistry v-model="modelValue.all.children.target.vars.cri_containerd_insecure_registries">
    </ContainerManagerRegistry>
  </ConfigSection>
</template>

<script lang="ts" setup>
import ContainerManagerRegistry from './ContainerManagerRegistry.vue';
import { inject, ref } from "vue";

const t = inject("t");

const modelValue = defineModel<any>();

const enabled = ref(true)

defineProps<{
  resourcePackage: any;
}>()

const prop = 'all.children.target.vars'

</script>
