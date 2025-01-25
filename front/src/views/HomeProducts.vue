<script setup>
import { onMounted } from 'vue';
import ProductCard from '../components/ProductCard.vue';
import { storeToRefs } from 'pinia';
import { useProductStore } from '@/stores/product';
import { useRoute, useRouter } from 'vue-router';

const router = useRouter();
const route = useRoute();

const { productsList, currentProduct } = storeToRefs(useProductStore());

const fetchProducts = async () => {
  if ('fromSearch' in route.query && route.query['fromSearch'] === 'true') {
    return
  }

  try {
    const response = await fetch('http://localhost:3000/products');
    if (!response.ok) {
      throw new Error(`Erro na requisição: ${response.statusText}`);
    }
    productsList.value = await response.json();
    console.log("teste", productsList.value)
  } catch (error) {
    console.error('Erro ao buscar produtos:', error);
  }
};

onMounted(fetchProducts);

function handleProduct(product) {
  currentProduct.value = product;

  router.push({ path: '/product' })
}
</script>

<template>

  <a-card title="Todos os produtos" :bordered="false" class="products-card">
    <template v-if="productsList.length > 0">
      <div class="product-list">
        <ProductCard v-for="product in productsList" :key="product.id" :imageSrc="product.product_img"
          :rating="product.rating_value" :productName="product.product_name" :productValue="product.product_value"
          @click="handleProduct(product)" />
      </div>
    </template>
    <template v-else>
      <p>Não há produtos.</p>
    </template>
  </a-card>

</template>

<style scope>
.products-card {
  width: 95%;
  margin: 15px auto 45px auto;
  top: 64px;
  height: 100%;
}

.product-list {
  display: flex;
  flex-wrap: wrap;
  gap: 15px;
  justify-content: flex-start;
}

.product-list>* {
  flex: 0 1 auto;
  box-sizing: border-box;
}
</style>
