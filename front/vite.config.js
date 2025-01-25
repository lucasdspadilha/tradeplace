import { fileURLToPath, URL } from 'node:url'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueDevTools from 'vite-plugin-vue-devtools'

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    vueDevTools(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    },
  },
  server: {
    proxy: {
      // Proxy para redirecionar chamadas para /users para o backend em http://127.0.0.1:3000
      '/users': 'http://127.0.0.1:3000',  // ou http://localhost:3000
      '/posts': 'http://127.0.0.1:3000',  // Se houver outras rotas de API
    },
  },
})
