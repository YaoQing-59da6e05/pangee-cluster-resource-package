<template>
  <div class="config">
    <ConfigGlobal :resource-package="resourcePackage" v-model="inventory" @refresh="$emit('refresh')"></ConfigGlobal>
  </div>
</template>

<script lang="ts" setup>
import ConfigGlobal from "./global/ConfigGlobal.vue";
import { provide } from "vue";

const inventory = defineModel();

const emit = defineEmits(['refresh']);

provide("defaultLabelWidth", "200px")

defineProps<{
  resourcePackage: any;
  abc: any;
}>()

</script>

<style scoped>
.config {
  line-height: 28px;
}
</style>