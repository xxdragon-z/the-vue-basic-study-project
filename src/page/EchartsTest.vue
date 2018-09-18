<!--suppress ALL -->
<template>
  <div id="content">
    <el-button @click="echartChange">点击切换图表</el-button>
    <div id="echartLine" style="height: 400px;width:100%" align="center"></div>
  </div>
</template>

<script>
  import echarts from 'echarts'

  export default {
    name: "EchartsTest",
    data() {
      var autoResize=function(){
        document.getElementById('echartLine').style.width= window.innerWidth
        document.getElementById('echartLine').style.height=window.innerHeight
      }
      // var labelOption = {
      //   normal: {
      //     show: true,
      //     position: app.config.position,
      //     distance: app.config.distance,
      //     align: app.config.align,
      //     verticalAlign: app.config.verticalAlign,
      //     rotate: app.config.rotate,
      //     formatter: '{c}  {name|{a}}',
      //     fontSize: 16,
      //     rich: {
      //       name: {
      //         textBorderColor: '#fff'
      //       }
      //     }
      //   }
      // }
      return {
        type: 'line',
        echartTable: '',
        ecahrtTitle: ['员工总分数', '平均总分数', '平均基础分数', '员工基础分数'],
        echartData: [
          {name: '员工总分数', stack: '员工总分数', type: 'line', data: [190, 195, 187, 185, 175, 179, 190]},
          {name: '平均总分数', stack: '平均总分数', type: 'line', data: [187, 181, 188, 189, 190, 171, 172]},
          {name: '平均基础分数', stack: '平均基础分数', type: 'line', data: [170, 171, 168, 169, 170, 170, 165]},
          {name: '员工基础分数', stack: '员工基础分数', type: 'line', data: [172, 170, 169, 168, 167, 169, 172]}
        ],
        echartBarData: [
          {name: '员工总分数', stack: '员工总分数', type: 'bar', data: [190, 195, 187, 185, 175, 179, 190]},
          {name: '平均总分数', stack: '平均总分数', type: 'bar', data: [187, 181, 188, 189, 190, 171, 172]},
          {name: '平均基础分数', stack: '平均基础分数', type: 'bar', data: [170, 171, 168, 169, 170, 170, 165]},
          {name: '员工基础分数', stack: '员工基础分数', type: 'bar', data: [172, 170, 169, 168, 167, 169, 172]}
        ],
        xData: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
      }
    },
    mounted() {
      this.echartTable = echarts.init(document.getElementById('echartLine'))
      let test=this.echartTable
      window.onresize=function(){
        document.getElementById('echartLine').style.width= window.innerWidth
        document.getElementById('echartLine').style.height=window.innerHeight
        test.resize()
      }

      if (echartLine)
        this.initEchart()
    },
    methods: {
      initEchart: function () {
        this.echartTable.setOption({
          toolbox: {
            show: true,
            orient: 'vertical',
            left: 'right',
            top: 'center',
            feature: {
              mark: {show: true},
              dataView: {show: true, readOnly: false},
              magicType: {show: true, type: ['line', 'bar']},
              restore: {show: true},
              saveAsImage: {show: true}
            }
          },
          title: {
            text: '线形图表'
          },
          tooltip: {
            trigger: 'axis'
          },
          legend: {
            data: this.echartTitle
          },
          grid: {
            containLabel: true
          },
          xAxis: {
            type: 'category',
            //此值决定当使用柱状图时，每一组数据自动分组自动适应长度或者是宽度
            boundaryGap: false,
            data: this.xData
          },
          yAxis: {
            type: 'value'
          },
          series: this.echartData
        })
      },
      echartChange: function () {
        if (this.type == 'line') {
          this.type = 'bar'
          this.echartData.forEach((item, index) => {
            this.echartData[index].type = 'bar'
          })
        }
        else {
          this.type = 'line'
          this.echartData.forEach((item, index) => {
            this.echartData[index].type = 'line'
          })
        }
        switch (this.type) {
          case'line':
            this.echartTable.setOption({
              xAxis: {
                type: 'category',
                boundaryGap: false,
                data: this.xData
              },
              series: this.echartData
            })
            break
          case'bar':
            this.echartTable.setOption({
              xAxis: {
                type: 'category',
                boundaryGap: true,
                data: this.xData
              },
              series: this.echartData
            })
            break
        }
      }
    }
  }
</script>

<style scoped>

</style>
