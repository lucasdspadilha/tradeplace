<script setup>
import BrandHeader from '../components/layout/BrandHeader.vue'
import DefaultFooter from '../components/layout/DefaultFooter.vue'
import Login from '../views/Login.vue'
import NewUser from '../views/NewUser.vue';
</script>

<template>
  <a-layout class="main-layout">
    
    <BrandHeader />

    <a-layout-content>
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
</style>