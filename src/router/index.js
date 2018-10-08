import Vue from 'vue'
import Router from 'vue-router'
import MainPage from '@/components/MainVue'

Vue.use(Router)

let routers = new Router({
  routes: [
    {
      path: '/',
      name: 'MainPage',
      component: MainPage,
      children: [
        {path: '/TablePage', name: 'TablePage', component: resolve=>require(['@/components/TablePage'],resolve)},
        {path: '/FirstDemoVue', name: 'FirstDemoVue', component: resolve=>require(['@/components/FirstDemoVue'],resolve)},
        {path: '/FormDemoVue', name: 'FormDemoVue', component: resolve=>require(['@/components/FormDemoVue'],resolve)}
      ]
    },
    // {
    //   path: '/TablePage',
    //   name: 'TablePage',
    //   component: TablePage
    // },

  ]
})
export default routers
