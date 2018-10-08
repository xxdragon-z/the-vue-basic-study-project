<template>
  <div id="body">
    <div id="title">
      <div id="title_left_div">
        <span><a @click="jumpTo('/FirstDemoVue')">首页</a></span>
      </div>
    </div>
    <div id="content">
      <template>
        <div id="content-left">
          <el-row v-show="true">
            <!-- 注意：这里就是topNavState作用之处，根据当前路由所在根路由的type值判断显示不同顶部导航菜单 -->
            <el-col :span="24">
              <el-menu :default-active="$router.path" class="el-menu-demo" mode="horizontal"
                       :router="true">
                <el-menu-item index="/FirstDemoVue">工作台</el-menu-item>
                <el-menu-item index="/FormDemoVue">企业管理</el-menu-item>
                <el-menu-item index="/TablePage">订单管理</el-menu-item>
                <el-menu-item index="/EchartsTest">图标测试</el-menu-item>
              </el-menu>
            </el-col>
          </el-row>
          <!--<el-menu-->
          <!--router-->
          <!--class="el-menu-vertical-demo"-->
          <!--background-color="#545c64"-->
          <!--text-color="#fff"-->
          <!--active-text-color="#ffd04b"-->
          <!--:default-active="$route.path"-->
          <!--&gt;-->
          <!--<el-submenu>-->
          <!--<el-menu-item-group>-->
          <!--<el-menu-item index="/FirstDemoVue">点击跳转页面</el-menu-item>-->
          <!--</el-menu-item-group>-->
          <!--</el-submenu>-->
          <!--</el-menu>-->
        </div>
      </template>
      <div id="content-right">
        <router-view></router-view>
      </div>
    </div>
    <div id="footer"></div>
  </div>
</template>

<script>
  export default {
    name: "mainPage",
    methods: {
      jumpTo(url) {
        this.$router.push(url)
      }
    }
  }
</script>

<style scoped>
  #body {
    border: 1px black solid;
    width: 100%;
  }

  #title {
    border: 1px black solid;
    width: 100%;
  }

  #title_left_div {
    border: 1px black solid;
    width: 100px;
    height: 100px;
  }

  #content {
    border: 1px solid red;
    width: 100%;
    height: 1000px;
  }

  #content-left {
    border: 1px blue solid;
    width: 19%;
    height: 400px;
    float: left;
  }

  #content-right {
    border: 1px black solid;
    width: 80%;
    height: 800px;
    float: left;
  }
</style>

