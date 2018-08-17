<template>
  <div id="FirstBody">
    <span>哟哟哟!{{hello}}</span>
    <ol>
      <!--<li id="uls" v-for="c in categoryList">{{c}}</li>-->
      <li v-bind:title="msg">{{msg}}</li>
    </ol>

  </div>
</template>
<script>
  import API from '../api/FirstAPI'

  export default {
    name: 'FirstDemoVue',
    data() {
      return {
        msg:'',
        categoryList:[],
        hello: '第一个组件'
      }
    },
    methods: {
      initData:function(data){
        this.msg = data.msg
        this.categoryList = data.data
      },
      flushData: function () {
        let that = this
        API.getRequest("/api/devices/query").then(this.initData);
        console.info("查询成功")
        // msg=result.msg
        // that.load = true
      }
    },
    mounted() {
      this.flushData()
    },
    loading: false
  }
</script>

<style scoped>

</style>
