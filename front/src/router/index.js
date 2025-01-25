import { createRouter, createWebHistory } from 'vue-router'
import DefaultSearchLayout from '../layouts/DefaultSearchLayout.vue'
import DefaultBrandLayout from '../layouts/DefaultBrandLayout.vue'
import Login from '../views/Login.vue'
import NewUser from '../views/NewUser.vue'
import addProduct from '@/views/sales/Product.vue'
import UserManager from '@/views/user/UserManager.vue'
import DefaultContentLayout from '@/layouts/DefaultContentLayout.vue'
import ProductPage from '@/views/customer/ProductPage.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: DefaultSearchLayout,
    },
    {
      path: '/login',
      name: 'login',
      component: DefaultBrandLayout,
      children: [
        {
          path: '',
          name: 'loginPage',
          component: Login,
        },
      ],
    },
    {
      path: '/new-user',
      name: 'newUser',
      component: DefaultBrandLayout,
      children: [
        {
          path: '',
          name: 'newUserPage',
          component: NewUser,
        },
      ]
    },
    {
      path: '/trade',
      name: 'salesProduct',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: DefaultContentLayout,
      children: [
        {
          path: 'sales/product',
          name: 'salesProductPage',
          component: addProduct
        },
        {
          path: 'profile',
          name: 'userManeger',
          component: UserManager
        }
      ]
    },
    {
      path: '/product',
      name: 'productPage',
      component: DefaultContentLayout,
      children: [
        {
          path: '',
          name: 'customerProductPage',
          component: ProductPage
        }
      ]
    }
  ],
})

export default router
