import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

// noinspection JSAnnotator
const store =new Vuex.Store({
  state :{
    count:0
  },
  mutations:{
    add(){
      this.state.count++
      console.info(this.state.count)
    },
    reduce(){
      this.state.count--
      console.info(this.state.count)
    }
  }
})
export default store


