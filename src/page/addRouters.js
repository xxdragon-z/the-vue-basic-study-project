export default {
  filterRouter: function (data) {
    console.info(data)
    this.$router.options.routes[3].children.push({
      name: '首页',
      path: '/dashboard',
      menuShow: true,
      component: reslove => require(['@/page/Dashboard'], reslove)
    })
    data.forEach((item, index) => {
      if (index <= 3) {
        this.$router.options.routes.push({
          path: '/',
          component: reslove => require(['@/page/Home'], reslove),
          name: item.name,
          menuShow: true,
          iconCls: item.qxtb,
          children: []
        })
        console.info('索引' + index)
        item.children.forEach((childs, i) => {
          console.info('path' + childs.qqdz + '===' + childs.qxmc)
          this.$router.options.routes[4 + index].children.push({
            name: childs.qxmc,
            path: childs.qqdz,
            menuShow: true,
            component: reslove => require([('@/page' + childs.qqdz)], reslove)
          })
        })
      }
    })
    this.$router.addRoutes(this.$router.options.routes)
    console.info('开始跳转')
    this.$router.push('/dashBoard')
  }
}
