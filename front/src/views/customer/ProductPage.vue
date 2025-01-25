<script setup>
import Comment from '@/components/comments/Comment.vue';
import { useProductStore } from '@/stores/product';
import AddReviewModal from './Components/AddReviewModal.vue';
import { ref } from 'vue';
const isAuthenticated = localStorage.getItem('auth_token') !== null
const { getProduct } = useProductStore();
const productAmount = ref(1);
const showReviewModal = ref(false);

const openReviewModal = () => {
  showReviewModal.value = true;
};
</script>

<template>
  <div class="page-container flex">
    <div class="product-container rounded container-shadow">
      <div class="main-product flex">
        <div class="pic-container" id="mock">
          <img width="400" height="400" :src="getProduct.product_img" :alt="getProduct.product_name">
        </div>
        <div class="description-container">
          <a-typography-title id="product-name">{{ getProduct.product_name }}</a-typography-title>
          <div id="rating" class="flex items-center" style="margin-bottom: 1em;">
            <div class="rating" style="margin-right: 10px; font-size: 1.5em;">{{ getProduct.rating_value }}</div>
            <a-rate disabled v-model:value="getProduct.rating_value" allow-half />
          </div>
          <p style="font-size: 18px"><strong>Descrições e informações do produto</strong></p>
          <a-typography-text>{{ getProduct.product_description }}</a-typography-text>
        </div>
      </div>
      <div id="comments">
        <a-button v-if="isAuthenticated" class="create-button" type="primary" style="margin-top: 2em;background-color: #50C878;" @click="openReviewModal">Faça seu review do produto.</a-button>
        <Comment />
      </div>
    </div>
    <div class="price-container rounded container-shadow">
      <h4>
        Novo por:
      </h4>
      <div>
        {{ getProduct.product_value }}
      </div>
      <div>
        Calcule o frete:
      </div>
      <div class="flex price-action-container">
        <div class="input-frete">
          00000-000
        </div>
        <button type="button" class="price-action-btn">
          Calcular
        </button>
        <div id="amount-label" class="amount-label">
          Selecione a quantidade:
        </div>
        <a-input-number id="inputNumber" class="price-action-btn" v-model:value="productAmount" :min="1" :max="10" />
      </div>
      <button type="button" class="buy-now-btn">
        Comprar Agora
      </button>
      <button type="button" class="add-tocart-btn">
        Adicionar ao carrinho
      </button>
    </div>
  </div>
  <AddReviewModal v-model="showReviewModal" />
</template>

<style scoped>
.page-container {
  gap: 1em;
  padding: 0 4em 0 4em;
}

.container-shadow {
  box-shadow: 0 0 6px 0px rgba(0, 0, 0, 0.15)
}

.product-container {
  width: 70%;
  height: 930px;
  background-color: white;
  display: flex;
  flex-direction: column;
  padding: 3em 6em;
}

.price-container {
  width: 30%;
  height: 350px;
  background-color: white;
  color: black;
  padding: 2em;
}

.rounded {
  border-radius: 15px;
}

.pic-container {
  min-width: 400px;
  min-height: 400px;
  background-color: gray;
}

.description-container {
  display: flex;
  flex-direction: column;
}

.rating {
  font-size: 2.35rem;
}

.main-product {
  color: black;
  gap: 3em;
}

.input-frete {
  width: 166px;
  border: 1px solid black;
  border-radius: 5px;
  text-align: center;
}

.price-action-container {
  flex-wrap: wrap;
  width: 300px;
}

.price-action-btn {
  background-color: #287D9C;
  border-radius: 8px;
  color: white;
  appearance: none;
  outline: none;
}

.buy-now-btn {
  background-color: #50C878;
  color: white;
  border-radius: 8px;
  width: 276px;
  height: 45px;
  font-size: 25px;
}

.add-tocart-btn {
  background-color: #003366;
  color: white;
  border-radius: 8px;
  width: 276px;
  height: 45px;
  font-size: 25px;
}
</style>
