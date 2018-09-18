import Vue from 'vue'
import Router from 'vue-router'
import TablePage from '@/components/TablePage'
import FirstDemoVue from '@/components/FirstDemoVue'
import FormDemoVue from '@/components/FormDemoVue'
import MainPage from '@/components/MainVue'
import EchartsTest from '@/page/EchartsTest'
import App from '@/App'

Vue.use(Router)

let routers = new Router({
  routes: [
    {
      path: '/',
      name: 'MainPage',
      component: MainPage,
      children: [
        {path: '/TablePage', name: 'TablePage', component: TablePage},
        {path: '/FirstDemoVue', name: 'FirstDemoVue', component: FirstDemoVue},
        {path: '/FormDemoVue', name: 'FormDemoVue', component: FormDemoVue},
        {path:'/EchartsTest',name:'EchartsTest',component:EchartsTest}
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
