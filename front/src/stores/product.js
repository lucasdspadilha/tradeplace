import { ref, computed } from 'vue'
import { defineStore } from 'pinia'

export const useProductStore = defineStore('product', () => {
  const currentProduct = ref()
  const productsList = ref([])
  const getProduct = computed(() => currentProduct.value)

  return { currentProduct, getProduct, productsList }
}, { persist: true })
