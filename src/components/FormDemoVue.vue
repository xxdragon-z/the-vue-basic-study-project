<template>
  <div id="formDiv">
    <el-form>
      <table>
        <tr>
          <td>
            <span>姓名：
            </span>
          </td>
          <td>
            <el-input id="name"></el-input>
          </td>
        </tr>
        <tr>
          <td>
            <span>性别</span>
          </td>
          <td>
            <el-select id="select_gender" v-model="gender.text" placeholder="请选择性别">
              <el-option v-for="(g) in gender" :key="g.id" :value="g.id" :label="g.text"></el-option>
            </el-select>
          </td>
        </tr>
        <tr>
          <td>
            <el-cascader :options="cityInfo"
                         :clearable="true"
                         :filterable="true">
            </el-cascader>
          </td>
        </tr>
        <tr>
          <td><button @click="initCity">添加</button></td>
        </tr>
      </table>
    </el-form>
  </div>
</template>

<script>
  var gender = [
    {text: '男', id: 1},
    {text: '女', id: 2}
  ]
  var info = [{
    value: 1, label: '北京', children: [
      {
        value: 1, label: '北京市', children: [
          {value: 1, label: '东城区'}, {value: 2, label: '西城区'},
          {value: 3, label: '崇文区'}, {value: 4, label: '宣武区'},
          {value: 5, label: '朝阳区'}, {value: 6, label: '丰台区'},
          {value: 7, label: '石景山区'}, {value: 8, label: '海淀区'},
          {value: 9, label: '门头沟区'}, {value: 10, label: '房山区'},
          {value: 11, label: '通州区'}, {value: 12, label: '顺义区'},
          {value: 13, label: '昌平区'}, {value: 14, label: '大兴区'},
          {value: 15, label: '怀柔区'}, {value: 16, label: '平谷区'},
          {value: 17, label: '密云县'}, {value: 18, label: '延庆县'}
        ]
      }]
  }]
  export default {
    name: "FormDemoVue",
    data() {
      return {
        gender: '',
        cityInfo:[]
          // [{label: '123', value: 1, children: [{label: '123', value: 1,children:[{label: '123', value: 1}]}]}]
      }
    },
    methods: {
      initCity: function(){
        info.forEach(c=>{
         let city={label:c.label,value:c.value,children:[]}
         c.children.forEach(c2=>{
           console.info(c2.label)
           let city2={label:c2.label,value:c2.value,children:[]}
           city.children.push(city2)
           c2.children.forEach(c3=>{
             let city3={label:c3.label,value:c3.value}
             city2.children.push(city3)
           })
         })
         // infos.push(city)
       this.cityInfo.push(city)
        })

      }
    },
    mounted() {
      // this.initCity(info)
    }

  }
</script>

<style scoped>

</style>
