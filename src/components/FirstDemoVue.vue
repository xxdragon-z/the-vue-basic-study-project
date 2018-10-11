<template>
  <div id="FirstBody">
    <span>哟哟哟!{{hello}}</span>
    <ol>
      <!--<li id="uls" v-for="c in categoryList">{{c}}</li>-->
      <!--<li v-bind:title="msg">{{msg}}</li>-->
      <li>
        <span id="lis">{{text.name}}</span>
      </li>
      <li>
        <button @click="adds">增加</button>
      </li>
      <li>
        <button @click="reduce">删除</button>
      </li>
    </ol>

  </div>
</template>
<script>
  import API from '../api/FirstAPI'

  export default {
    name: 'FirstDemoVue',
    data() {
      return {
        text: {name: 'ceshi'},
        msg: '',
        categoryList: [],
        hello: '第一个组件',
        texts: [{name: '1'}, {name: '2'}],
        index: 0
      }
    },
    methods: {
      adds() {
        this.$store.commit('add')
      },
      reduce() {
        this.$store.commit('reduce')
      },
      animates: function () {
        if (this.index < this.texts.length - 1)
          this.index++
        else
          this.index = 0
        this.text.name = this.texts[this.index].name
      },
      initData: function (data) {
        this.msg = data.msg
        this.categoryList = data.data
      },
      flushData: function () {
        API.getRequest("/subways/devices/query").then(this.initData)
        console.info("查询成功")
        // msg=result.msg
        // that.load = true
      }
    },
    mounted() {
      setInterval(this.animates, 1000)
      this.flushData()
    },
    loading: false
  }
</script>

<style scoped>

</style>
