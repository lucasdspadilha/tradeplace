<template>
    <a-modal
      v-model:visible="isModalVisible"
      :title="modalTitle"
      @cancel="closeModal"
      footer=""
    >
    <div class="form-div">
        <a-form
        :model="formState"
        @finish="handleSubmit"
        >
        <!-- Informações do Usuário -->
        <a-form-item class="label-text" label="Nome" name="name" :rules="[{ required: true, message: 'Por favor, insira seu nome!' }]">
            <a-input v-model:value="formState.name" placeholder="Insira seu nome" />
        </a-form-item>

        <a-form-item class="label-text" label="Email" name="email" :rules="[{ required: true, message: 'Por favor, insira seu email!' }]">
            <a-input v-model:value="formState.email" placeholder="Insira seu email" />
        </a-form-item>

        <a-form-item label="Senha" name="password" :rules="[{ required: true, message: 'Por favor, insira sua senha!' }]">
            <a-input-password v-model:value="formState.password" placeholder="Insira sua senha" />
        </a-form-item>

        <a-form-item class="label-text" label="Telefone" name="phone">
            <a-input v-model:value="formState.phone" placeholder="(00) 00000-0000" />
        </a-form-item>

        <!-- Tipo de Usuário -->
        <a-form-item label="Tipo de Usuário" name="user_type">
            <a-switch
            v-model:value="formState.user_type"
            :checkedChildren="'Vendedor/Usuário'"
            :unCheckedChildren="'Usuário'"
            />
        </a-form-item>

        <!-- Seção de Endereço -->
        <a-divider>Informações de Endereço</a-divider>

        <a-form-item class="label-text" label="Rua" name="street">
            <a-input v-model:value="formState.address.street" placeholder="Digite a rua" />
        </a-form-item>

        <a-form-item class="label-text" label="Número" name="number">
            <a-input v-model:value="formState.address.number" placeholder="Digite o número" />
        </a-form-item>

        <a-form-item class="label-text" label="Bairro" name="neighborhood">
            <a-input v-model:value="formState.address.neighborhood" placeholder="Digite o bairro" />
        </a-form-item>

        <a-form-item class="label-text" label="CEP" name="cep">
            <a-input v-model:value="formState.address.cep" placeholder="Digite o CEP" />
        </a-form-item>

        <a-form-item class="label-text" label="Complemento" name="complement">
            <a-input v-model:value="formState.address.complement" placeholder="Digite o complemento" />
        </a-form-item>

        <a-form-item class="label-text" label="Cidade" name="city">
            <a-input v-model:value="formState.address.city" placeholder="Digite a cidade" />
        </a-form-item>

        <!-- Botão de Envio -->
        <a-form-item class="login-button-form" style="display: flex; justify-content: flex-end;">
            <a-button class="edit-button" type="primary" html-type="submit">Salvar</a-button>
        </a-form-item>
        </a-form>
    </div>
    </a-modal>
  </template>
  
  <script setup>
  import { ref, onMounted } from 'vue'
  import axios from 'axios'
  import { Form, Input, InputPassword, Button, Switch, Divider } from 'ant-design-vue'
  
  const props = defineProps({
    modalTitle: {
      type: String,
      required: true
    },
    modalContent: {
      type: String,
      required: true
    }
  })
  
  const formState = ref({
    id: null,  // Adicionando um campo ID para o usuário, caso já exista
    name: '',
    email: '',
    password: '',
    phone: '',
    user_type: 'user', // Valor padrão
    address: {
      id: null,  // ID do endereço, caso o endereço seja editado
      street: '',
      number: '',
      neighborhood: '',
      cep: '',
      complement: '',
      city: ''
    }
  })
  
  const fetchUserData = async (userId) => {
    try {
      const response = await axios.get(`http://localhost:3000/users/${userId}`);
      const user = response.data.user;
      
      formState.value.id = user.id;  
      formState.value.name = user.name;
      formState.value.email = user.email;
      formState.value.phone = user.phone;
      formState.value.user_type = user.user_type;

      if (user.address) {
        formState.value.address.id = user.address.id;  
        formState.value.address.street = user.address.street;
        formState.value.address.number = user.address.number;
        formState.value.address.neighborhood = user.address.neighborhood;
        formState.value.address.cep = user.address.cep;
        formState.value.address.complement = user.address.complement;
        formState.value.address.city = user.address.city;
      }
    } catch (error) {
      console.error('Erro ao buscar dados do usuário:', error);
      alert('Erro ao carregar os dados do usuário');
    }
  }

  onMounted(() => {
    const userId = 1; 
    fetchUserData(userId);
  })
  
  const handleSubmit = async () => {
    try {
      const userData = {
        name: formState.value.name,
        email: formState.value.email,
        password: formState.value.password,
        phone: formState.value.phone,
        user_type: formState.value.user_type,
      }

      const addressData = {
        street: formState.value.address.street,
        number: formState.value.address.number,
        neighborhood: formState.value.address.neighborhood,
        cep: formState.value.address.cep,
        complement: formState.value.address.complement,
        city: formState.value.address.city,
        user_id: formState.value.id
      };
  
      if (formState.value.id) {
        var addressResponse = {}
        if (formState.value.address.id) {
            addressResponse = await axios.put(`http://localhost:3000/addresses/${formState.value.address.id}`, { address: addressData });
          console.log('Endereço atualizado com sucesso:', addressResponse.data);
        } else {
            addressResponse = await axios.post('http://localhost:3000/addresses', { address: addressData });
          console.log('Endereço criado com sucesso:', addressResponse.data);
        }

        const userResponse = await axios.put(`http://localhost:3000/users/${formState.value.id}`, { user: {...userData, address_id: addressResponse.data.id} });
        console.log('Usuário atualizado com sucesso:', userResponse.data);        
      } else {
        const addressResponse = await axios.post('http://localhost:3000/addresses', { address: addressData });
        console.log('Endereço criado com sucesso:', addressResponse.data);
      }
  
      closeModal();
    } catch (error) {
      console.error('Erro ao salvar os dados:', error);
      alert('Erro ao salvar os dados. Tente novamente!');
    }
  }

  const emit = defineEmits(['update:visible'])
  const isModalVisible = ref(false)
  const closeModal = () => {
    isModalVisible.value = false
    emit('update:visible', false)
  }
  </script>
  
  
  
  <style scoped>
    .login-button-form {
    display: flex;
    justify-content: flex-end; 
    }

    .edit-button {
        background-color: #50C878;
    }

    .edit-button:hover {
    background-color: #48B474 !important;
    transform: scale(1.01);
    }


  /* Estilos para o modal (se necessário) */
  </style>
  