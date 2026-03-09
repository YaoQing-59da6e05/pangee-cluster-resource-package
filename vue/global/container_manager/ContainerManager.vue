<i18n>
en:
  cm_label: ContainerManager
  cm_description: Container Manager
  cri_containerd_insecure_registries_place_holder: e.g. http://10.99.0.8:5000
zh:
  cm_label: 容器引擎
  cm_description: 设置集群范围内所有节点使用的容器引擎相关参数
  cri_containerd_insecure_registries_place_holder: 例如：http://10.99.0.8:5000
</i18n>

<template>
  <ConfigSection v-model:enabled="enabled" :label="t('cm_label')" :description="t('cm_description')" disabled
    anti-freeze>
    <EditArray v-model="modelValue.all.children.target.vars.cri_containerd_insecure_registries" :prop="prop + '.cri_containerd_insecure_registries'" label="cri_containerd_insecure_registries" :item-rules="registryRules">
      <template #editItem="scope">
        <el-input v-model.trim="modelValue.all.children.target.vars.cri_containerd_insecure_registries[scope.index]" :placeholder="t('cri_containerd_insecure_registries_place_holder')"></el-input>
      </template>
    </EditArray>
  </ConfigSection>
</template>

<script lang="ts" setup>
import { inject, ref } from "vue";

const t = inject("t");

const modelValue = defineModel<any>();

const enabled = ref(true)

defineProps<{
  resourcePackage: any;
}>()

const prop = 'all.children.target.vars'

const registryRules = [
  { 
    required: true, 
    type: 'string', 
    message: '字段不能为空', 
    trigger: 'blur' 
  },
  {
    pattern: /^https?:\/\/[a-zA-Z0-9][a-zA-Z0-9\-\.]*[a-zA-Z0-9](:[0-9]+)?$/, 
    message: '必须以 http:// 或 https:// 开头，包含有效的域名或IP地址，可包含端口号', 
    trigger: 'blur' 
  }
]

</script>
