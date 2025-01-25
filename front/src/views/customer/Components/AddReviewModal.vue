<script setup>
import { ref, watch } from 'vue';
import { message } from 'ant-design-vue';
import axios from 'axios';
import { useProductStore } from '@/stores/product';

const { getProduct } = useProductStore();
const props = defineProps({
  modelValue: Boolean, 
  productId: Number,   
});

const emit = defineEmits(['update:modelValue']);
const isVisible = ref(false);
const rating = ref(0);
const comment = ref('');

watch(() => props.modelValue, (newValue) => {
  isVisible.value = newValue;
});

const handleSubmit = async () => {
  if (!rating.value || !comment.value.trim()) {
    message.error('Por favor, forneça uma avaliação e um comentário.');
    return;
  }

  try {
    const response = await axios.post(`http://127.0.0.1:3000/products/${getProduct.id}/feedbacks`, {
      feedback: {
        user_id: 1,
        rating_value: rating.value,
        comment: comment.value,
      }
    });

    message.success(response.data.message);

    isVisible.value = false;
    rating.value = 0;
    comment.value = '';
    emit('update:modelValue', false); 
  } catch (error) {
    message.error('Erro ao enviar a avaliação. Tente novamente.');
  }
};

const handleCancel = () => {
  isVisible.value = false;
  emit('update:modelValue', false); 
};
</script>

<template>
  <a-modal
    :open="isVisible"
    title="Adicione seu review"
    @ok="handleSubmit"
    @cancel="handleCancel"
    ok-text="Enviar"
    cancel-text="Cancelar"
  >
    <div>
      <p>Nota:</p>
      <a-rate v-model:value="rating" allow-half />
    </div>
    <div style="margin-top: 16px;">
      <a-textarea
        v-model:value="comment"
        placeholder="Nos dê sua opinião sobre o produto."
        :auto-size="{ minRows: 2, maxRows: 5 }"
      />
    </div>
  </a-modal>
</template>
