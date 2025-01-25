<script setup>
import { ref } from 'vue';
import { message } from 'ant-design-vue';

function getBase64(img, callback) {
  const reader = new FileReader();
  reader.addEventListener('load', () => callback(reader.result));
  reader.readAsDataURL(img);
}
const fileList = ref([]);
const loading = ref(false);
const imageUrl = ref('');
const handleChange = info => {
  if (info.file.status === 'uploading') {
    loading.value = true;
    return;
  }
  if (info.file.status === 'done') {
    getBase64(info.file.originFileObj, base64Url => {
      imageUrl.value = base64Url;
      loading.value = false;
    });
  }
  if (info.file.status === 'error') {
    loading.value = false;
    message.error('upload error');
  }
};
const beforeUpload = file => {
  const isJpgOrPng = file.type === 'image/jpeg' || file.type === 'image/png';
  if (!isJpgOrPng) {
    message.error('You can only upload JPG file!');
  }
  const isLt2M = file.size / 1024 / 1024 < 2;
  if (!isLt2M) {
    message.error('Image must smaller than 2MB!');
  }
  return isJpgOrPng && isLt2M;
};
</script>

<template>
  <a-card :bordered="false" style="background-color: #287D9C;" class="register-card">
    <template #title>
      <h1 class="content-title text-center">
        Cadastre seu produto
      </h1>
    </template>
    <a-form layout="vertical" class="text-center">
      <a-form-item label="Nome do produto" name="name"
        :rules="[{ required: true, message: 'Por favor, insira o nome do produto' }]">
        <a-input type="text" id="name" />
      </a-form-item>
      <a-form-item label="Descreva o produto" name="description"
        :rules="[{ required: true, message: 'Por favor, insira a descrição do produto' }]">
        <a-textarea id="description" />
      </a-form-item>
      <div class="flex justify-between">
        <div class="w-1/2">
          <a-form-item label="Valor" name="price">
            <a-input-number id="price" />
          </a-form-item>
          <a-form-item label="Quantidade" name="amount">
            <a-input-number type="number" id="amount" />
          </a-form-item>
        </div>
        <div class="w-1/2 flex items-center justify-end">
          <a-upload v-model:file-list="fileList" name="photos" list-type="picture-card" class="avatar-uploader"
            :show-upload-list="false" :before-upload="beforeUpload" @change="handleChange">
            <img v-if="imageUrl" :src="imageUrl" alt="avatar" />
            <div v-else>
              <loading-outlined v-if="loading"></loading-outlined>
              <plus-outlined v-else></plus-outlined>
              <div class="ant-upload-text">Upload</div>
            </div>
          </a-upload>
        </div>
      </div>
      <a-button style="background-color: #50C878; color: white;">Anuncie!</a-button>
    </a-form>
  </a-card>
</template>

<style scope>
label,
input {
  display: block
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
