<script setup>
import { ref, onMounted } from 'vue';
import ProductCard from '../components/ProductCard.vue';
import { useProductStore } from '@/stores/product';
import { storeToRefs } from 'pinia';
import { useRouter } from 'vue-router';

const products = ref([]);

const fetchProducts = async () => {
  try {
    const response = await fetch('http://localhost:3000/products');
    if (!response.ok) {
      throw new Error(`Erro na requisição: ${response.statusText}`);
    }
    products.value = await response.json();
    console.log("teste", products)
  } catch (error) {
    console.error('Erro ao buscar produtos:', error);
  }
};

onMounted(fetchProducts);
</script>

<template >

      <a-card :bordered="false" class="products-card">
        <template v-if="products.length > 0">
            <div class="product-list">
                <ProductCard
                v-for="product in products"
                :key="product.id"
                :imageSrc="product.product_img"
                :rating="product.rating_value"
                :productName="product.product_name"
                :productValue="product.product_value"
                />
            </div>
        </template>
        <template v-else>
            <p>Carregando produto...</p>
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

    .product-list > * {
    flex: 0 1 auto; 
    box-sizing: border-box;
    }
</style>
