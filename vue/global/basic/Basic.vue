<i18n>
en:
  basic_label: Basic Setup
  basic_description: Basic Setup, used to set some global variables.

zh:
  basic_label: 基础配置
  basic_description: 基础配置，用于设置一些全局变量。
  root_dir_place_holder: 文件路径，例如：/apps
</i18n>

<template>
  <ConfigSection v-model:enabled="enabled" :label="t('basic_label')" :description="t('basic_description')" disabled
    anti-freeze>
    <EditString v-model="modelValue.all.children.target.vars.root_dir" :prop="prop + '.root_dir'" label="root_dir"
      :placeholder="t('root_dir_place_holder')">
    </EditString>
    <EditArray v-model="modelValue.all.children.target.vars.ntp_server" :prop="prop + '.ntp_server'" label="ntp_server">
      <template #editItem="scope">
        <el-input v-model.trim="modelValue.all.children.target.vars.ntp_server[scope.index]"></el-input>
      </template>
    </EditArray>
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