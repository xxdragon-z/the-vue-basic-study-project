<template>
  <div>
    <el-button @click="test">点击刷新数据</el-button>
    <div id="echart_line" style="width: 100%;height: 400px;" align="center"/>
  </div>
</template>
<script>
  import echarts from 'echarts'
  import API from '@/api/api_score'
  export default {
    name: 'EmployeeScoreCharts',
    props: ['chartData', 'chartTitle', 'url', 'params', 'xData'],
    data () {
      return {
        echartDatas: this.chartData,
        echartLine: null,
        echartTitle: this.chartTitle,
        urlPath: this.url,
        urlParams: this.params,
        xAxisData: this.xData
      }
    },
    mounted () {
      this.echartLine = echarts.init(document.getElementById('echart_line'))
      this.loadData()
    },
    methods: {
      flushChartData: function () {
        API.flushData(this.urlPath, this.urlParams).then(this.initCharts, (err) => {
          this.$message.error(err.toString())
        }).catch(res => {
          this.$message.error(res.msg)
        })
      },
      test: function () {
        this.flushChartData()
      },
      loadData: function () {
        this.chartTable()
        // this.initCharts('')
      },
      initCharts: function (res) {
        // 图表的数据
        this.echartDatas = res.data ? res.data : this.echartDatas
        // 图标的数据标题
        this.echartTitle = res.title ? res.title : this.echartTitle
        // 图标的横向x时间轴内容
        this.xAxisData = res.xData ? res.xData : this.xAxisData
        this.echartLine.setOption({
          series: this.echartDatas,
          legend: {
            data: this.echartTitle
          },
          xAxis: {
            data: this.xAxisData
          }
        })
      },
      chartTable: function () {
        this.echartLine.setOption({
          title: {
            text: 'Line Chart'
          },
          tooltip: {
            trigger: 'axis'
          },
          legend: {
            data: this.echartTitle
          },
          grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
          },
          xAxis: {
            type: 'category',
            boundaryGap: false,
            data: this.xAxisData
          },
          yAxis: {
            type: 'value'
          },
          series: this.echartDatas
        })
      }
    }
  }
</script>
<style scoped>

</style>
