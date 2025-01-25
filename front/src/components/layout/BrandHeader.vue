<script setup>
    import { Layout } from 'ant-design-vue'
    import { useRouter } from 'vue-router'
</script>

<template>
    <a-layout-header class="header">
        <div class="logo">
            <router-link to="/" class="logo">
                <img alt="TradePlace logo" class="logo-img" src="@/assets/logo.svg" width="125" height="125" />
            </router-link>
        </div>
    </a-layout-header>
</template>


<style scoped>
.header {
  display: flex;
  justify-content: center; 
  align-items: center;
  background-color: #287D9C;
}
</style>
