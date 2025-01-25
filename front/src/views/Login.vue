<script setup>
import { reactive } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'
import { message } from 'ant-design-vue' 

const router = useRouter()
const user = reactive({
    email: '',
    password: '',
});

const handleLogin = async (values) => {
  try {
    const response = await axios.post('http://localhost:3000/api/login', {
      email: values.email,
      password: values.password,
    });

    if (response.data.success) {
      localStorage.setItem('auth_token', response.data.token);
      message.success('Login bem-sucedido!');
      router.push('/');
    } else {
      message.error('Credenciais inválidas. Tente novamente.');
    }
  } catch (error) {
    console.error('Erro na requisição:', error);
    message.error('Ocorreu um erro ao tentar fazer login.');
  }
}


const goToNewUserPage = () => {
  router.push('/new-user') 
}
</script>

<template>
  <div class="centered-container">
    <a-card :bordered="false" class="login-card">
      <a-typography-text :level="2" class="title">Faça seu login</a-typography-text>

      <div class="form-div">
        <a-form 
        :model="user"
        @finish="handleLogin"
        layout="vertical">
          <a-form-item class="label-text" label="Email" name="email">
            <a-input v-model:value="user.email" placeholder="Insira seu Email" />
          </a-form-item>

          <a-form-item label="Senha" name="password">
            <a-input-password v-model:value="user.password" placeholder="Insira sua senha" />
          </a-form-item>

          <a-form-item class="login-button-form">
            <a-button class="login-button" type="primary" html-type="submit">Login</a-button>
          </a-form-item>
        </a-form>
      </div>

      <div class="create-button-div">
        <a-typography-text :level="2" class="new-user-title">Novo aqui?</a-typography-text>
        <a-button class="create-button" type="primary" @click="goToNewUserPage">Criar sua conta</a-button>
      </div>
    </a-card>
  </div>
</template>

<style scoped>
.centered-container {
  background-color: #D9D9D9;
  display: flex;
  justify-content: center;
  align-items: center;
  height: calc(100vh - 96px);
}

.title {
  display: flex;
  justify-content: center;
  font-size: 25px;
  color: white;
  margin-bottom: 30px;
}

.form-div {
  width: 80%;
  margin: auto;
}

label {
  color: white !important;
  font-size: 15px !important;
}

.login-card {
  width: 50%;
  margin: auto;
  background-color: #287D9C;
  color: white;
  max-width: 600px;
}

.login-button-form {
  display: flex;
  justify-content: center;
  margin-top: 30px;
}

.login-button {
  width: 120px;
  background-color: #50C878;
}

.login-button:hover {
  background-color: #48B474 !important;
  transform: scale(1.05);
}

.new-user-title {
  font-size: 20px;
  color: white;
}

.create-button {
  width: 150px;
  background-color: #50C878;
}

.create-button-div {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  gap: 10px;
  margin-top: 45px;
}

.create-button:hover {
  background-color: #48B474 !important;
  transform: scale(1.05);
}
</style>
