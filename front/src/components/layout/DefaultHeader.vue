<script setup>
    import { useProductStore } from '@/stores/product';
    import { storeToRefs } from 'pinia';
    import { useRoute, useRouter } from 'vue-router'
  
    const router = useRouter()
    const route = useRoute()

    const productStore = storeToRefs(useProductStore());
    // Verificar se o usuário está logado verificando a existência do token JWT
    const isAuthenticated = localStorage.getItem('auth_token') !== null
  
    const goToLoginPage = () => {
      router.push('/login')  // Redireciona para a página /login
    }
  
    const handleLogout = () => {
      // Remover o token do localStorage
      localStorage.removeItem('auth_token')
      
      // Redireciona para a página de login após o logout
      router.push('/login')
    }

    let currentPath = route.path;

    let filterBackup = [];
    function handleSearch(ev) {
      filterBackup = productStore.productsList.value;
      if (route.path === '/') {
        if (!ev) {
          productStore.productsList.value = filterBackup;
          return
        }
        productStore.productsList.value = productStore.productsList.value.filter(p => p.product_name.toLowerCase().includes(ev.toLowerCase()));
        return
      }

      productStore.productsList.value = filterBackup.filter(p => p.product_name.toLowerCase().includes(ev.toLowerCase()));
    router.push({ path: '/', query: { fromSearch: true } })
    }
  </script>

<template>
  <a-layout-header class="header">
    <!-- Logo -->
    <div role="button" class="logo" @click="currentPath === '/' ? $router.go({ path: '/', force: true }) : $router.push({ path: '/' })">
          <img alt="TradePlace logo" class="logo-img" src="@/assets/logo.svg" width="125" height="125" />
    </div>

    <!-- Busca -->
    <div class="search-container">
          <a-input-search
              placeholder="Pesquise o que precisa..."
              class="custom-search"
              @search="handleSearch($event)"
              >
              <template #enterButton>
                  <a-button class="custom-button">Buscar</a-button>
              </template>
          </a-input-search>
      </div>

    <div class="header-actions">
      <a-button type="link" class="shopping-cart-button">
        <img alt="TradePlace logo" class="logo-img" src="@/assets/shopping_cart.svg" width="27" height="24" />
        <span>Carrinho</span>
      </a-button>
      <a-button
        v-if="!isAuthenticated"
        type="primary"
        class="login-button"
        @click="goToLoginPage"
      >
        Login/Criar
      </a-button>
      <a-button
        v-if="isAuthenticated"
        type="primary"
        class="login-button"
        @click="handleLogout"
      >
        Logout
      </a-button>
      <a-button
        v-if="isAuthenticated && currentPath !== '/trade/profile'"
        type="primary"
        class="login-button"
        @click="$router.push('/trade/profile')"
      >
        Perfil
      </a-button>
    </div>
  </a-layout-header>
</template>
  
  

<style scoped>
    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0 20px;
      width: 100%;
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      z-index: 1000;
      background-color: #287D9C; /* Cor de fundo do header */
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); /* Sombras para destacar o header */
    }
  
    .logo {
        display: flex;
        align-items: center;
        cursor: pointer;
    }
  
    .logo-img {
      max-width: 100%; /* Garante que a imagem se ajuste corretamente */
    }
  
    .search-container {
      flex-grow: 1;
      display: flex;
      justify-content: center;
    }
  
    .header-actions {
      display: flex;
      gap: 10px;
    }
  
    .custom-search {
      width: 550px;
    }
  
    .custom-button {
      background-color: #003366; 
      color: white !important; 
      border: none; 
    }
  
    .custom-button:hover {
      background-color: #003D7A;
    }
  
    .login-button {
      background-color: #50C878;
    }
  
    .login-button:hover {
      background-color: #48B474;
    }
  
    .shopping-cart-button {
      color: #50C878;
    }
  
    .shopping-cart-button:hover {
      color: #58D884; 
    }
  </style>
  
