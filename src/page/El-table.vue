<template>
  <div id="countManagerPage1">
    <!--表头导航-->
    <el-row class="warp">
      <el-col :span="24" class="warp-breadcrum">
        <el-breadcrumb separator="/">
          <el-breadcrumb-item :to="{ path: '/' }"><b>站点管理</b></el-breadcrumb-item>
          <el-breadcrumb-item>积分查询</el-breadcrumb-item>
        </el-breadcrumb>
        <el-col align="center">
          <el-row>
            <el-input placeholder="输入公司名称进行查询" style="max-width: 240px;width:15%" v-model="companyName"></el-input>
            <el-button @click="findByName" type="primary">查询</el-button>
            <el-button type="danger" icon="delete" @click="removeMore">批量删除</el-button>
            <el-button type="warning" @click="jumpToAddCompany">录入厂商</el-button>
          </el-row>
        </el-col>
        <el-col align="center">
          <el-table
            align="center"
            :border="true"
            :data="tableData"
            v-loading="loadStatus"
            size="mini"
            @selection-change="handleSelectChange"
            :default-sort="{prop: 'bh', order: 'ascending'}">
            <el-table-column type="selection"></el-table-column>
            <el-table-column prop="bh" label="编号" width="120px" sortable></el-table-column>
            <el-table-column prop="cjmz" label="厂商名称" width="240px" sortable></el-table-column>
            <el-table-column prop="cjdz" label="厂商地址" width="240px" sortable></el-table-column>
            <el-table-column prop="cjdh" label="联系电话" width="120px" sortable></el-table-column>
            <el-table-column prop="cjfr" label="法人代表" width="120px" sortable></el-table-column>
            <el-table-column prop="cjzfs" label="总积分" width="120px" sortable></el-table-column>
            <el-table-column prop="cjxfs" label="已扣除积分" width="120px" sortable></el-table-column>
            <el-table-column prop="saveScore" label="剩余积分" width="120px" sortable></el-table-column>
            <el-table-column label="操作" prop="bh" width="200px">
              <template slot-scope="scope">
                <el-button type="danger" size="small" @click="removeCompany(scope.$index,scope.row)">删除</el-button>
                <el-button type="warning" size="small" @click="serachCompany(scope.$index,scope.row)">编辑</el-button>
              </template>
            </el-table-column>
          </el-table>
          <el-footer>
            <div id="footer_center_div" align="center">
              <el-pagination
                background
                @size-change="handleSizeChange"
                @current-change="handleCurrentChange"
                :current-page="pageNum"
                :page-sizes="[10, 15, 20, 25]"
                :page-size="length"
                layout="total, sizes, prev, pager, next, jumper"
                :total="totalCount">
              </el-pagination>
            </div>
          </el-footer>
        </el-col>
      </el-col>
    </el-row>
    <el-dialog
      title="厂商编辑"
      :visible.sync="dialogVisible"
      @close="dialogClose"
    >
      <!--:before-close="dialogBeforeClose"-->
      <div id="dialog_div">
        <el-tabs @click="tabsClick">
          <el-tab-pane label="信息修改">
            <div>
              <el-form :model="company" :rules="companyRule" ref="company" label-width="100px">
                <el-form-item label="厂商名称" prop="cjmz">
                  <el-input class="form_input" v-model="company.cjmz"></el-input>
                </el-form-item>
                <el-form-item label="厂商电话" prop="cjdh">
                  <el-input class="form_input" v-model="company.cjdh"></el-input>
                </el-form-item>
                <el-form-item label="厂商地址" prop="cjdz">
                  <el-input class="form_input" v-model="company.cjdz"></el-input>
                </el-form-item>
                <el-form-item label="法人代表" prop="cjfr">
                  <el-input class="form_input" v-model="company.cjfr"></el-input>
                </el-form-item>
                <el-form-item label="厂商备注" prop="bz">
                  <el-input class="form_input" v-model="company.bz"></el-input>
                </el-form-item>
                <el-form-item label="是否可用" prop="zt">
                  <el-select v-model="company.zt" placeholder="请选择" class="form_input">
                    <el-option v-for="(item) in usable" :key="item.value" :value="item.value"
                               :label="item.label"></el-option>
                  </el-select>
                </el-form-item>
                <el-form-item>
                  <el-button type="primary" @click="modifyCompany('company')">确定修改</el-button>
                </el-form-item>
              </el-form>
            </div>
          </el-tab-pane>
          <el-tab-pane label="三证修改">
            <div>
              <div style="width: 100%;height: 60px;" align="center" v-if="show&&imgs.length<3">
                <el-button type="primary" @click="show=false">上传图片</el-button>
              </div>
              <div v-if="show" style="margin:10px;width:30%;float:left;" align="center" v-for="(item,index) in imgs">
                <img :src="'http://192.168.3.10:8888/'+item" style="width:100%;height:300px;"/>
                <el-button type="danger" @click="removeCompanyImage(item)">点击删除图片</el-button>
              </div>
              <div v-if="!show">
                <el-form>
                  <el-form-item label="图片上传">
                    <el-upload
                      ref="upload"
                      action="/uploadCompanayImage"
                      :auto-upload="false"
                      :multiple="imgs.length<2"
                      accept="image/jpg"
                      :imagePath="imagePath"
                      :limit="3-imgs.length"
                      list-type="picture-card"
                      :before-remove="beforeRemove"
                      :before-upload="beforeUploadImage"
                      :on-success="handleSuccess"
                      :on-change="handleChange">
                      <el-button type="primary" slot="trigger">选择照片</el-button>
                      <el-button type="success" @click="submitImage" :disabled="!imageSubmitable">上传图片</el-button>
                      <div slot="tip" class="el-upload__tip" align="center"><span>最多上传{{3-imgs.length}}张照片</span>
                        <el-row>
                          <el-button @click="updateCompanyImage" size="middle" type="primary">确认更改</el-button>
                        </el-row>
                      </div>
                    </el-upload>
                  </el-form-item>
                </el-form>
              </div>
              <div v-if="(imgs.length==0&&show)">
                <span>还没有上传图片呢</span>
              </div>
            </div>
          </el-tab-pane>
          <el-tab-pane label="积分充值">
            <div>
              <el-form :model="company2" :rules="companyRule2" ref="company2" label-width="100px">
                <el-form-item label="厂商名称">
                  <el-input class="form_input" v-bind:value="company2.cjmz" :disabled="true"></el-input>
                </el-form-item>
                <el-form-item label="总计积分">
                  <el-input class="form_input" v-bind:value="company2.cjzfs" :disabled="true"></el-input>
                </el-form-item>
                <el-form-item label="扣除积分">
                  <el-input class="form_input" v-model="company2.cjxfs" :disabled="true"></el-input>
                </el-form-item>
                <el-form-item label="可用积分">
                  <el-input class="form_input" v-model="company2.saveScore" :disabled="true"></el-input>
                </el-form-item>
                <el-form-item label="充值积分" prop="addScore">
                  <el-input class="form_input" v-model="company2.addScore" v-on:input="scoreChange"></el-input>
                </el-form-item>
                <el-form-item>
                  <el-button @click="addCompanyScores('company2')" type="primary">确定充值</el-button>
                </el-form-item>
              </el-form>
            </div>
          </el-tab-pane>
        </el-tabs>
      </div>
    </el-dialog>
  </div>
</template>
<script>
  import API from '@/api/api_cjxx'
  import validators from '@/api/validator_cjxx'

  export default {
    name: 'page2',
    data: function () {
      return {
        imageSubmitable: false,
        imagePath: [],
        fileList: [],
        usable: [
          {value: 0, label: '可用'},
          {value: 1, label: '停用'}],
        tableData: [],
        findWay: '',
        id: '',
        ids: '',
        params: {},
        companyName: '',
        pageNum: 0,
        length: 10,
        loadStatus: true,
        totalCount: 0,
        selectedRow: [],
        dialogVisible: false,
        addScore: '',
        show: true,
        submitable: true,
        company: {cjmz: '', cjdz: '', cjdh: '', cjfr: '', bz: ''},
        company2: {cjmz: '', cjzfs: '', cjxfs: '', saveScore: '', addScore: ''},
        imgs: [],
        companyRule: {
          cjmz: [{validator: validators.notNull, tigger: 'blur'}],
          cjdh: [{validator: validators.checkphone, tigger: 'blur'}],
          cjdz: [{validator: validators.notNull, tigger: 'blur'}],
          cjfr: [{validator: validators.notNull, tigger: 'blur'}],
          bz: [{validator: validators.notNull, tigger: 'blur'}]
        },
        companyRule2: {
          addScore: [{validator: validators.mustNumber, tigger: 'blur'}]
        }
      }
    },
    mounted () {
      this.loadTableData()
    },
    methods: {
      updateCompanyImage: function () {
        this.show = true
        this.imagePath.forEach(item => {
          this.company.cjzp += (item + ',')
          this.imgs.push(item)
        })
        this.imageSubmitable = false
        API.modifyCompanyById(this.company).then(res => {
          if (res.code == 0) {
            this.imagePath = []
            this.$message.success('更改成功')
            this.fileList = []
          } else {
            this.$message.error('更新失败，请刷新页面重试')
          }
        })
        this.fileList = []
      },
      beforeUploadImage: function (file) {
        let testmsg = file.name.substring(file.name.lastIndexOf('.') + 1)
        const extension = testmsg === 'png'
        const extension2 = testmsg === 'jpg'
        const isLt2M = file.size / 1024 / 1024 < 5
        if (!extension && !extension2) {
          this.$message({
            message: '上传文件只能是 jpg、png!',
            type: 'warning'
          })
          return false
        }
        if (!isLt2M) {
          this.$message({
            message: '上传文件大小不能超过 5MB!',
            type: 'warning'
          })
          return false
        }
        this.fileList.push(file)
        return true
      },
      beforeRemove: function (file, fileList) {
        if (fileList.length == 0) {
          this.imageSubmitable = false
        }
        console.info('资源列表' + fileList.length)
        for (let j = 0, l = fileList.length; j < l; j++) {
          if (file == fileList[j]) {
            console.info('找到目标' + file.name)
            if (this.fileList.length > j) {
              this.fileList.splice(j, 1)
              API.removeCompanyImage({fileName: this.imagePath[j]}).then(res => {
                if (res.code == 0) {
                  for (let i = 0, k = this.imagePath.length; i < k; i++) {
                    if (this.imagePath[i] == res.path) {
                      this.imagePath.splice(i, 1)
                      this.$message({
                        type: 'success',
                        message: '删除上传照片成功'
                      })
                      break
                    }
                  }
                } else {
                  this.$message.error('删除上传照片失败')
                }
              })
            } else {
              this.$message.success('删除预览照片成功')
            }
            break
          }
        }
      },
      handleChange: function (file, fileList) {
        if (fileList.length == 0) {
          this.imageSubmitable = false
        } else {
          this.imageSubmitable = true
        }
      },
      submitImage: function () {
        this.$refs.upload.submit()
      },
      handleSuccess: function (res) {
        if (res.code == 0) {
          this.$message.success('上传成功')
          this.imagePath.push(res.path)
        } else {
          this.$message.error('上传失败')
        }
      },
      // dialogBeforeClose: function () {
      //   this.$confirm('确定关闭？', '系统提示').then(() => {
      //     this.dialogVisible = false
      //     this.show = true
      //     this.company = {}
      //     this.company2 = {}
      //   }).catch(() => {
      //   })
      // },
      dialogClose: function () {
        this.show = true
        console.info('关闭')
        this.company = {}
        this.company2 = {}
      },
      removeCompanyImage: function (path) {
        this.company.cjzp = ''
        for (let i = 0; i < this.imgs.length; i++) {
          if (path == this.imgs[i]) {
            this.imgs.splice(i, 1)
            console.info('删除了' + this.imgs.length)
          }
        }
        for (let i = 0, k = this.imgs.length; i < k; i++) {
          this.company.cjzp += (this.imgs[i] + ',')
        }
        console.info('厂家照片' + this.company.cjzp)
        API.modifyCompanyById(this.company).then(res => {
          if (res.code == 0) {
            API.removeCompanyImage({fileName: path}).then(res => {
              if (res.code == 0) {
                this.$message.success('删除成功')
              } else {
                this.$message.error('删除失败')
              }
            })
          }
        })
      },
      scoreChange: function () {
        const numReg = /^\d+$/
        let scores = this.company2.addScore
        if (numReg.test(scores)) {
          this.company2.cjzfs = (parseInt(this.company.cjzfs) + parseInt(scores))
          this.company2.saveScore = (parseInt(this.company.saveScore) + parseInt(scores))
        }
      },
      addCompanyScores: function (formName) {
        this.$refs[formName].validate(valid => {
          if (valid) {
            let companys = {bh: this.company.bh, cjzfs: this.company2.addScore}
            API.inputCompanyScoreById(companys).then(res => {
              if (res.code == 0) {
                this.resetForm(formName)
                this.$message.success('充值成功！')
                this.dialogVisible = false
                this.loadTableData()
              } else {
                this.$message.success('充值失败！')
              }
            })
          } else {
            this.$message.warning('请输入充值额度')
          }
        })
      },
      resetForm: function (formName) {
        console.info('重置')
        this.company2 = {}
        this.company = {}
        this.$refs[formName].resetFields()
      },
      modifyCompany: function (formName) {
        this.$refs[formName].validate(valid => {
          if (valid) {
            API.modifyCompanyById(this.company).then(res => {
              if (res.code == 0) {
                this.resetForm(formName)
                this.$message.success('修改成功')
                this.loadTableData()
                this.dialogVisible = false
              } else {
                this.$message.error('修改失败')
              }
            })
          } else {
            this.$message.warning('表单格式不正确')
          }
        })
      },
      tabsClick: function () {

      },
      removeMore: function () {
        if (this.selectedRow.length == 0) {
          this.$message.error('找不到删除的目标')
        } else {
          this.loadStatus=true
          this.selectedRow.forEach(row => {
            this.ids += row.bh
            this.ids += ','
          })
          API.removeCompanyById(this.ids).then(res => {
            if (res.code == 0) {
              this.loadTableData()
              this.$message.success('批量删除成功')
            } else {
              this.$message.error('删除可能不完整')
              this.loadStatus=false
            }
            this.selectedRow = []
          }).catch(res=>{
            this.selectedRow = []
            this.loadStatus=false
          })
          this.ids=''
        }
      },
      jumpToAddCompany: function () {
        this.$router.push('/manManager/page10')
      },
      handleSelectChange: function (val) {
        this.selectedRow = val
      },
      serachCompany: function (index, row) {
        this.findWay = 'id'
        this.id = row.bh
        API.findCompanyScoreByManyWay({
          pageNum: this.pageNum,
          length: this.length,
          findWay: this.findWay,
          id: this.id,
          companyName: this.companyName
        }).then(res => {
          if (res.code == 0) {
            this.imgs = []
            this.findWay = ''
            this.company = res.cjXxList[0]
            this.company2.cjmz = this.company.cjmz
            this.company2.cjzfs = this.company.cjzfs
            this.company2.cjxfs = this.company.cjxfs
            this.company2.saveScore = this.company.saveScore
            if (this.company.cjzp) {
              let us = this.company.cjzp.split(',')
              if (us.length > 0) {
                us.forEach(item => {
                  if (item != '') {
                    this.imgs.push(item)
                  }
                })
              }
            }
            if (this.company.zt == '可用') {
              this.company.zt = 0
            } else {
              this.company.zt = 1
            }
            this.dialogVisible = true
          } else {
            this.$message.error('查询失败')
          }
        })
      },
      removeCompany: function (index, row) {
        this.loadStatus = true
        API.removeCompanyById(row.bh).then(res => {
          if (res.code == 0) {
            this.$message.success('删除成功')
            this.loadTableData()
          } else {
            this.$message.error('删除失败')
          }
          this.loadStatus = false
        }).catch(res => {
          this.loadStatus = false
        })
      },
      handleSizeChange: function (val) {
        this.length = val
        this.loadTableData()
      },
      handleCurrentChange: function (val) {
        this.pageNum = val
        this.loadTableData()
      },
      findByName: function () {
        this.findWay = 'cName'
        this.loadTableData()
      },
      loadTableData: function () {
        this.loadStatus = true
        API.findCompanyScoreByManyWay({
          pageNum: this.pageNum,
          length: this.length,
          findWay: this.findWay,
          id: this.id,
          companyName: this.companyName
        }).then(this.initData).catch(res=>{
          this.loadStatus=false
        })
      },
      initData: function (data) {
        if (data.code == 0) {
          this.totalCount = data.total
          this.tableData = data.cjXxList
          this.loadStatus = false
        }
      }
    }
  }
</script>

<style scoped>
  .form_input {
    width: 30%;
    max-width: 240px;
  }

  #dialog_div {
    margin: 0 auto;
  }
</style>
