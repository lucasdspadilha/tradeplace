<script setup>
import { ref } from 'vue';
import { useProductStore } from '@/stores/product';
import { message } from 'ant-design-vue';
import { storeToRefs } from 'pinia';
import axios from 'axios';
const productStore = storeToRefs(useProductStore());
const props = defineProps({
  modalTitle: {
    type: String,
    required: true
  },
  modalContent: {
    type: String,
    required: true
  }
});

const isModalVisible = ref(false)
const emit = defineEmits(['update:visible'])
const closeModal = () => {
isModalVisible.value = false
emit('update:visible', false)
}
const imageUrl = ref(''); 
const productName = ref('');
const productDescription = ref('');
const productPrice = ref(0);
const productAmount = ref(0);

function getBase64(img, callback) {
  const reader = new FileReader();
  reader.addEventListener('load', () => callback(reader.result)); 
  reader.readAsDataURL(img); 
}
const beforeUpload = file => {
  const isJpgOrPng = file.type === 'image/jpeg' || file.type === 'image/png';
  if (!isJpgOrPng) {
    message.error('Você pode subir apenas arquivos JPG ou PNG!');
    return false;
  }
  const isLt2M = file.size / 1024 / 1024 < 2;
  if (!isLt2M) {
    message.error('A imagem deve ter menos de 2MB!');
    return false;
  }
  getBase64(file, base64Url => {
        imageUrl.value = base64Url;
    });
  return false;
};

const submitProduct = async () => {
  const productData = {
    product_name: productName.value,
    product_description: productDescription.value,
    product_value: productPrice.value,
    qty_available: productAmount.value,
    product_img: imageUrl.value,
    qty_sold: 0,
    rating_value: 0,
  };

  try {
    const response = await axios.post('http://localhost:3000/products', productData);
    if (response.status === 200 || response.status === 201) {
      message.success('Produto cadastrado com sucesso!');

        const responseNewProducts = await fetch('http://localhost:3000/products');
        if (!responseNewProducts.ok) {
        throw new Error(`Erro na requisição: ${responseNewProducts.statusText}`);
        }

        productStore.productsList.value = await responseNewProducts.json();

        productName.value = ''
        productDescription.value = ''
        productPrice.value = 0
        productAmount.value = 0
        imageUrl.value = ''

    }
  } catch (error) {
    message.error('Erro ao cadastrar o produto!');
  } finally {
    closeModal();
  }
};

</script>

<template>
  <a-modal v-model:visible="isModalVisible" :title="modalTitle" @cancel="closeModal" footer="">
    <a-form layout="vertical" class="text-center">
      <a-form-item label="Nome do produto" name="name">
        <a-input v-model:value="productName" type="text" id="name" />
      </a-form-item>
      <a-form-item label="Descreva o produto" name="description">
        <a-textarea v-model:value="productDescription" id="description" />
      </a-form-item>
      <div class="flex justify-between">
        <div class="w-1/2">
          <a-form-item label="Valor" name="price">
            <a-input-number v-model:value="productPrice" id="price" />
          </a-form-item>
          <a-form-item label="Quantidade" name="amount">
            <a-input-number v-model:value="productAmount" type="number" id="amount" />
          </a-form-item>
        </div>
        <div class="w-1/2 flex items-center justify-end">
          <a-upload
            
            name="photos"
            :before-upload="beforeUpload"
            :max-count="1"
          >
            <a-button>
                <upload-outlined></upload-outlined>
                Selecione a imagem
            </a-button>
          </a-upload>
        </div>
      </div>
      <a-button @click="submitProduct" style="background-color: #50C878; color: white;">Anuncie!</a-button>
    </a-form>
  </a-modal>
</template>

<style scoped>
label,
input {
  display: block;
}

form {
  width: 480px;
  margin: auto !important;
}

.ant-upload-select-picture-card i {
  font-size: 32px;
  color: #999;
}

.ant-upload-select-picture-card .ant-upload-text {
  color: #666;
}

.ant-upload.ant-upload-select {
  margin: 0 !important;
}

.register-card {
  width: 715px;
  height: 800px;
  margin: auto;
}
</style>
