<template>
  <div id="main_body">
    <div id="left_div">
      <table>
        <tr>
          <th>id</th>
          <th>姓名</th>
          <th>公司</th>
          <th>操作</th>
        </tr>
        <tr v-for="c in companyList">
          <td v-model="c.id">{{c.id}}</td>
          <td v-model="c.name">{{c.name}}</td>
          <td v-model="c.cName">{{c.cName}}</td>
          <td>
            <button @click="remove(c.id)">删除</button>
          </td>
        </tr>
      </table>
    </div>
    <div id="right-div">
      <el-table :data="companyList" :border="true" highlight-current-row v-loading="false" size="small" width="400px">
        <el-table-column prop="id" label="编号" width="100px"></el-table-column>
        <el-table-column prop="name" label="姓名" width="100px"></el-table-column>
        <el-table-column prop="cName" label="公司" width="100px"></el-table-column>
        <el-table-column label="操作" min-width="140px">
          <template slot-scope="scope">
            <el-button size="small" type="success" @click="modifyUser(scope.$index, scope.row)">修改</el-button>
            <el-button size="small" type="danger" @click="deleteUser(scope.$index, scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>
<script>
  export default {
    data() {
      return {
        companyList: [
          {id: 1, name: '111', cName: '111s'},
          {id: 2, name: '222', cName: '222s'}
        ]
      }
    },
    methods: {
      deleteUser: (index, row) => {
        console.info(this.companyList)
        console.info("index=" + index + "row=" + row)
        console.info(row)
      },
      modifyUser: function (index, row) {
        console.info(this.companyList)
        console.info("index=" + index + "row=" + row)
        console.info(row)
      },
      remove: id => {
        console.info(id)
        console.info(this.companyList)
        // 两个无效的方法
        // for (var i=0,k=this.companyList.getLength();i<k;i++) {
        //   if(id==this.companyList[i].id)
        //     this.companyList.remove(c)
        //   else
        //     console.info(c.name)
        // }
        // for (var c in this.companyList){
        //   if (c.id=id) {
        //     this.remove(c)
        //   }else{
        //     console.info(c.id)
        //   }
        // }
      }
    }
  }
</script>
