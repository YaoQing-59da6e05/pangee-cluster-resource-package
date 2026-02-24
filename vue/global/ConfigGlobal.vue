<template>
  <div>
    <Basic :resource-package="resourcePackage" v-model="inventory" @refresh="emit('refresh')"></Basic>
    <ContainerManager :resource-package="resourcePackage" v-model="inventory" @refresh="emit('refresh')">
    </ContainerManager>
    <Etcd :resource-package="resourcePackage" v-model="inventory" @refresh="emit('refresh')"></Etcd>
    <Kubernetes :resource-package="resourcePackage" v-model="inventory" @refresh="emit('refresh')">
    </Kubernetes>
    <Calico :resource-package="resourcePackage" v-model="inventory" @refresh="emit('refresh')">
    </Calico>
    <Harbor :resource-package="resourcePackage" v-model="inventory" @refresh="emit('refresh')">
    </Harbor>
  </div>
</template>

<script lang="ts" setup>
import ContainerManager from "./container_manager/ContainerManager.vue";
import Kubernetes from "./kubernetes/Kubernetes.vue";
import Basic from "./basic/Basic.vue";
import Calico from "./calico/Calico.vue";
import Etcd from "./etcd/etcd.vue";
import Harbor from "./harbor/Harbor.vue";

const inventory = defineModel();

const emit = defineEmits(['refresh']);

defineProps<{
  resourcePackage: any;
  abc: any;
}>()

</script>

<style scoped></style>
