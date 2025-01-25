<template>
  <div class="card-container">
    <a-card class="card" title="Dados Pessoais" @click="openModal('user')">
      <p>Conteúdo do card de dados pessoais</p>
    </a-card>
    <!-- <a-card class="card" title="Seus Pedidos" @click="openModal('orders')">
      <p>Conteúdo do card de ajuda</p>
    </a-card> -->
    <!-- Card de Cadastre Produtos -->
    <a-card class="card" title="Cadastre produtos e anuncie." @click="openModal('products')">
      <p>Conteúdo do card de cadastro de produtos</p>
    </a-card>
    <!-- <a-card class="card" title="Produtos Anunciados" @click="openModal('announced')">
      <p>Conteúdo do card de produtos anunciados</p>
    </a-card> -->
  </div>
  <UserModal
    v-model:visible="isUserModalVisible"
    :modalTitle="'Dados e informações de usuário.'"
  />
  <NewProduct
    v-model:visible="isProductsModalVisible"
    :modalTitle="'Anuncie seu produto.'"
  />
</template>

<script setup>
import { ref } from 'vue'
import UserModal from './Components/UserModal.vue'
import NewProduct from './Components/NewProduct.vue'

const isUserModalVisible = ref(false)
const isOrdersModalVisible = ref(false)
const isProductsModalVisible = ref(false)
const isAnnouncedModalVisible = ref(false)

const openModal = (type) => {
  if (type === 'user') isUserModalVisible.value = true
  if (type === 'products') isProductsModalVisible.value = true
}
</script>

<style scoped>
.card-container {
  display: grid;
  grid-template-columns: repeat(2, 1fr); 
  gap: 16px; 
  margin-top: 20px;
  padding: 0 20px; 
}

.card {
  background-color: #f0f0f0;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease-in-out;
  width: 90%;
}

.card:hover {
  transform: scale(1.01);
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
}
</style>
