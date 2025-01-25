<script setup>
import DefaultHeader from '../components/layout/DefaultHeader.vue'
import DefaultFooter from '../components/layout/DefaultFooter.vue'
</script>

<template>
  <a-layout class="main-layout">
    <DefaultHeader />
    <a-layout-content class="content-area">
      <RouterView />
    </a-layout-content>
    <DefaultFooter />
  </a-layout>
</template>


<style scoped>
.main-layout {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.content-area {
  flex: 1;
  background-color: #D9D9D9;
  color: white;
  padding-bottom: 34px;
  padding-top: 8rem;
}
</style>
