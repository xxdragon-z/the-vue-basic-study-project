<template>
  <div id="countManagerPage3">
    <el-row class="warp">
      <el-col :span="24" class="warp-breadcrum">
        <el-breadcrumb separator="/">
          <el-breadcrumb-item :to="{ path: '/' }"><b>统计管理</b></el-breadcrumb-item>
          <el-breadcrumb-item>人员积分查询</el-breadcrumb-item>
        </el-breadcrumb>
      </el-col>
    </el-row>
    <el-row style="margin-top: 20px;">
      <el-tabs @click="tabsClick" @tab-click="tabChange" v-model="findWay.i">
        <el-tab-pane label="请假积分详情" name='10'/>
        <el-tab-pane label="值班积分详情" name="5"/>
        <el-tab-pane label="巡视积分详情" name="6"/>
        <el-tab-pane label="加班积分详情" name='7'/>
        <el-tab-pane label="维修积分详情" name="8"/>
      </el-tabs>
      <el-col align="center">
        <el-row>
          <el-input placeholder="输入名称进行查询" style="max-width: 240px;width:15%" v-model="findWay.name"></el-input>
          <el-date-picker type="month" placeholder="请选择月份" v-model="findWay.month" value-format="yyyy-MM"></el-date-picker>
          <el-button @click="loadTableData" type="primary">查询</el-button>
          <!--<el-button type="danger" icon="delete" @click="removeMore">批量删除</el-button>-->
        </el-row>
      </el-col>
      <el-col>
        <el-table
          align="center"
          :border="true"
          :data="tableData"
          v-loading="loadStatus"
          size="mini"
          @selection-change="handleSelectChange"
          :default-sort="{prop: 'id', order: 'ascending'}">
          <el-table-column prop="id" label="编号" width="120px" sortable></el-table-column>
          <el-table-column prop="name" label="姓名" width="120px" sortable></el-table-column>
          <el-table-column prop="workNum" label="人员工号" width="120px" sortable></el-table-column>
          <el-table-column prop="baseScore" label="基础分" width="120px" sortable></el-table-column>
          <el-table-column prop="extraScore" label="额外分数" width="120px" sortable></el-table-column>
          <el-table-column prop="vocationalType" label="业务名称" width="120px" sortable></el-table-column>
          <el-table-column prop="scoreChange" label="分数详情" width="120px" sortable></el-table-column>
          <el-table-column prop="operateTime" label="操作时间" width="200px" sortable></el-table-column>
          <el-table-column prop="operator" label="操作人" width="120px" sortable></el-table-column>
          <el-table-column label="操作" width="200px">
            <template slot-scope="scope">
              <el-button type="danger" size="small">删除</el-button>
              <el-button type="warning" size="small" @click="serachById(scope.$index,scope.row)">详情</el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-col>
    </el-row>
    <el-footer>
      <div class="footer_center_div" align="center">
        <el-pagination
          background
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="findWay.pageNum"
          :page-sizes="[10, 15, 20, 25]"
          :page-size="findWay.length"
          layout="total, sizes, prev, pager, next, jumper"
          :total="totalCount">
        </el-pagination>
      </div>
    </el-footer>
    <el-dialog
      title="分数对比图"
      :visible.sync="dialogVisible"
      :before-close="dialogClose">
      <EmployeeScoreCharts :chartData="echartData" :chartTitle="ecahrtTitle" :xData="xData" :url="echartUrl" :params="echartParams"></EmployeeScoreCharts>
    </el-dialog>
  </div>
</template>

<script>
  import API from '@/api/api_zdryjf'
  import EmployeeScoreCharts from '@/common/EmployeeScoreCharts'

  export default {
    name: 'page3',
    components: {EmployeeScoreCharts},
    data () {
      return {
        activeStatus: '10',
        tableData: [],
        loadStatus: 'no',
        selectedRow: [],
        totalCount: 0,
        echartLines: null,
        dialogVisible: false,
        findWay: {name: '', pageNum: 0, length: 10, i: '10', month: ''},
        ecahrtTitle: ['员工总分数', '平均总分数', '平均基础分数', '员工基础分数'],
        echartUrl: '/subways/getEmployee',
        echartParams: {},
        echartData: [
          {name: '员工总分数', stack: '员工总分数', type: 'line', data: [190, 195, 187, 185, 175, 179, 190]},
          {name: '平均总分数', stack: '平均总分数', type: 'line', data: [187, 181, 188, 189, 190, 171, 172]},
          {name: '平均基础分数', stack: '平均基础分数', type: 'line', data: [170, 171, 168, 169, 170, 170, 165]},
          {name: '员工基础分数', stack: '员工基础分数', type: 'line', data: [172, 170, 169, 168, 167, 169, 172]}
        ],
        xData: ['周一', '周二', '周三', '周四', '周五', '周六', '周日']
      }
    },
    mounted () {
      this.loadTableData()
    },
    methods: {
      initFindWay: function () {
        this.findWay.length = 10
        this.findWay.pageNum = 0
        this.findWay.name = ''
        this.findWay.month = ''
      },
      dialogClose: function () {
        this.dialogVisible = false
      },
      serachById: function (index, row) {
        console.info(row)
        this.dialogVisible = true
        // console.info(document.getElementById('echart_line'))
        // window.onresize = this.echartLine.resize()
        // this.echartLine.resize()
      },
      tabChange: function (tab, event) {
        this.initFindWay()
        this.loadTableData()
      },
      tabsClick: function () {

      },
      findByName: function () {

      },
      handleSelectChange: function (val) {
        this.selectedRow = val
      },
      handleSizeChange: function (val) {
        this.findWay.length = val
        this.loadTableData()
      },
      handleCurrentChange: function (val) {
        this.findWay.pageNum = val
        this.loadTableData()
      },
      loadTableData: function () {
        this.loadStatus = true
        API.findEmployeeListByManyWay(this.findWay).then(this.initData, err => {
          this.loadStatus = false
          this.$message.error(err.toString())
        }).catch(res => {
          this.$message.error(res.msg)
        })
      },
      initData: function (data) {
        if (data.code == 0) {
          this.totalCount = data.total
          this.tableData = data.tableList
          console.info(this.tableData)
          this.loadStatus = false
        }
      }
    }
  }
</script>

<style scoped>

</style>
