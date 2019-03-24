<template>
    <div id="bodys">
      <el-form :model="moduleParams" ref="form" :rules="moduleRules">
        <el-form-item v-for="(item,index) in dataList" :key="index" :prop="item.field" :label="item.name" >
          <el-input v-model="moduleParams[item.field]" @=change"test"></el-input>
        </el-form-item>
      </el-form>
    </div>
</template>

<script>
    export default {
        name: "TestVForWithValidate",
      data(){
          let checkAge=(rule,value,callback)=>{
            console.info("年龄：",value)
            let ageRegular=/\d+/
            if(ageRegular.test(value))
              return callback()
            else return new callback('请输入正确的年龄')
        };
        let checkPhone=(rule,value,callback)=>{
          console.info("手机号：",value)
          let phoneRegular=/1\d{10}/
          if(phoneRegular.test(value))
            return callback()
          else return  callback('请输入正确的手机')
        };
          return {
            moduleRules:{
              name:[{required:true,message:'请输入正确的姓名',trigger:'blur'}],
              age:[{validator:checkAge,trigger:'blur'}],
              phone:[{validator:checkPhone,trigger:'blur'}]
            },
            dataList:[{name:'姓名',field:'name',value:''},
              {name:'年龄',field:'age',value:''},
              {name:'手机号',field:'phone',value:''}],
            moduleParams:{
            }
          }
      },
      beforeMount(){
          // this.initParams()
      },
      created(){

      },
      mounted(){
        console.log(this.$refs.form)
      },
      methods:{
          test(val){
            console.info(val)
          },
          initParams(){
            let _this = this;
            //下面的东西可写可不写 ，最好写上
            _this.dataList.forEach((a,b)=>{
            _this.moduleParams[a.field]=""+b
            })
            console.info("module：",_this.moduleParams)
          }
      }
    }
</script>

<style scoped>
#bodys {
  width: 100%;
  height: 100%;

}
</style>
