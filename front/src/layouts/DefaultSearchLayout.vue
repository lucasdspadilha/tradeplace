<script setup>
import DefaultHeader from '../components/layout/DefaultHeader.vue'
import DefaultFooter from '../components/layout/DefaultFooter.vue'
import Products from '../views/HomeProducts.vue'
</script>

<template>
  <a-layout class="main-layout">
    <DefaultHeader />
        <a-layout-content class="content-area">
    <Products/>
        <RouterView />
      </a-layout-content>
    <DefaultFooter />
  </a-layout>
</template>


<style scoped>
.main-layout {
  display: flex;
  flex-direction: column;
  min-height: 100vh; /* Garante que o layout ocupe no mínimo a altura da tela */
}

.content-area {
  flex: 1; /* Faz o conteúdo crescer para preencher o espaço disponível */
  background-color: #D9D9D9;
  color: white;
  padding-bottom: 34px;
}
</style>