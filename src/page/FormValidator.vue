<template>
  <div id="manManagerPage10">
    <el-col>
      <el-row>
        <el-breadcrumb separator="/">
          <el-breadcrumb-item :to="{ path: '/' }"><b>人员管理</b></el-breadcrumb-item>
          <el-breadcrumb-item>厂商录入</el-breadcrumb-item>
        </el-breadcrumb>
      </el-row>
      <div id="content_div">
        <el-col>
          <el-form :model="company" :rules="companyRule" ref="company" label-width="100px">
            <el-form-item label="快速导入">
              <el-upload
                v-loading="getExcelData"
                class="upload-demo"
                action="/uploadCompanyExcel"
                :auto-upload="true"
                :limit="1"
                multiple
                ref="upload"
                :imagePath="excelPath"
                :file-list="excelList"
                :before-upload="checkFile"
                :on-remove="removeExcel"
                :onSuccess="uploadExcelSuccess"
                :on-exceed="indexWarn"
                :data="excelName">
                <el-button slot="trigger" size="small" type="primary">选取文件开始录入</el-button>
                <!--<el-button style="margin-left: 10px;" size="small" type="success" @click="submitExcel"-->
                <!--:disabled="(!insertKey)">开始录入数据-->
                <!--</el-button>-->
                <el-button @click="createCompanyExcel" type="success" size="small">生成模板</el-button>
                <div slot="tip" class="el-upload__tip">只能上传xls格式文件，且不超过10M</div>
              </el-upload>
            </el-form-item>
            <el-form-item label="批量上传">
              <UploadForMoreImage
                action="/uploadMoreCompanyImage">
              </UploadForMoreImage>
            </el-form-item>
            <el-form-item label="厂商名称" prop="name">
              <el-input class="form_input" v-model="company.name"></el-input>
            </el-form-item>
            <el-form-item label="厂商电话" prop="phone">
              <el-input class="form_input" v-model="company.phone"></el-input>
            </el-form-item>
            <el-form-item label="厂商地址" prop="address">
              <el-input class="form_input" v-model="company.address"></el-input>
            </el-form-item>
            <el-form-item label="法人代表" prop="legalPerson">
              <el-input class="form_input" v-model="company.legalPerson"></el-input>
            </el-form-item>
            <el-form-item label="操作人员" prop="createBy">
              <el-input class="form_input" v-model="company.createBy"></el-input>
            </el-form-item>
            <el-form-item label="初始积分" prop="score">
              <el-input class="form_input" v-model="company.score"></el-input>
            </el-form-item>
            <el-form-item label="厂商备注" prop="remark">
              <el-input class="form_input" v-model="company.remark"></el-input>
            </el-form-item>
            <el-form-item label="图片上传">
              <!--list-type="picture-card"-->
              <el-upload
                class="upload-demo"
                ref="upload"
                :action="imageAction"
                :imagePath="imagePath"
                multiple
                :limit="3"
                accept="image/jpg"
                :before-upload="beforeUploadImage"
                :on-change="handleChange"
                :before-remove="handleBeforeRemove"
                :on-preview="handlePreview"
                :onSuccess="uploadSuccess"
                :on-exceed="indexWarn"
                list-type="picture-card"
                :auto-upload="false">
                <el-button slot="trigger" size="small" type="primary">选取照片</el-button>
                <el-button style="margin-left: 10px;" size="small" type="success" @click="submitUpload"
                           :disabled="!uploadKey">上传照片
                </el-button>
                <div slot="tip" class="el-upload__tip">只能上传jpg文件三张，且不超过10mb</div>
              </el-upload>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="submitForm('company')">添加</el-button>
              <el-button @click="resetForm('company')">重置</el-button>
            </el-form-item>
          </el-form>
        </el-col>
      </div>
    </el-col>
  </div>
</template>

<script>
  import API from '@/api/api_cjxx'
  import UploadForMoreImage from '../../common/UploadForMoreImage'
  import validators from '@/api/validator_cjxx'
  export default {
    name: 'page10',
    components: {UploadForMoreImage},
    data () {
      return {
        company: {name: '', address: '', phone: '', score: '', createBy: '', url: '', legalPerson: '', remark: ''},
        company2: {cjmz: '', cjdz: '', cjdh: '', cjzfs: '', cjr: '', cjzp: '', cjfr: '', bz: ''},
        imagePath: [],
        imageAction: '/uploadCompanayImage',
        fileList: [],
        moreImageList: [],
        excelPath: [],
        excelList: [],
        getExcelData:false,
        companyRule: {
          name: [{validator: validators.notNull, tigger: 'blur'}],
          phone: [{validator: validators.checkphone, tigger: 'blur'}],
          address: [{validator: validators.notNull, tigger: 'blur'}],
          score: [{validator: validators.mustNumber, tigger: 'blur'}],
          createBy: [{validator: validators.notNull, tigger: 'blur'}],
          legalPerson: [{validator: validators.notNull, tigger: 'blur'}],
          remark: [{validator: validators.notNull, tigger: 'blur'}]
          // , url: [{validator: checkImagePath, tigger: 'blur'}]
        },
        insertKey: false,
        uploadKey: false,
        excelName: {fileName: ''}
      }
    },
    methods: {
      handleChange: function (file, fileList) {
        if (fileList.length > 0) {
          this.uploadKey = true
          // for (let i = 0, k = fileList.length - 1; i < k; i++) {
          //   if (file.name == fileList[i].name) {
          //     console.info('重复数据file='+file.name+"====fileListName="+fileList[i].name)
          //     fileList.splice(i, 1)
          //   }
          // }
        } else {
          this.uploadKey = false
        }
      },
      createCompanyExcel: function () {
        this.$message.info('开始生成模板')
        API.createCompanyExcelTemp().then(data => {
          let a = document.createElement('a')
          let blob = new Blob([data.data])
          a.download = '厂商录入模板.xls'
          a.href = window.URL.createObjectURL(blob)
          document.body.appendChild(a)
          a.click()
          URL.revokeObjectURL(blob)
        })
      },
      removeExcel: function (file, fileList) {
        if (this.excelPath.length > 0) {
          API.removeCompanyImage({fileName: this.excelPath[0]}).then(res => {
            if (res.code === 0) {
              this.insertKey = false
              this.excelList = []
              this.excelPath = []
              this.$message.success('删除成功')
            } else {
              this.$message.warning('删除异常')
            }
          })
        }
      },
      submitExcel: function () {
        API.insertMoreCompany(this.excelPath[0]).then(res => {
          if (res.code == 0) {
            this.$message.success('录入成功')
          } else {
            this.$message.error(res.msg)
          }
        })
        this.insertKey = false
        this.excelList = []
      },
      checkFile: function (file, fileList) {
        this.getExcelData=true
        const excelReg = /^([\u2E80-\u9FFFa-zA-Z0-9\(\) _-]+)+(\.xls)$/
        if (excelReg.test(file.name)) {
          const isLt2M = file.size / 1024 / 1024 < 5
          if (!isLt2M) {
            this.getExcelData=false
            this.$message({
              message: '上传文件大小不能超过 5MB!',
              type: 'warning'
            })
            return false
          }
          this.excelName.fileName = file.name
          this.excelList.push(file)
          return file
        } else {
          this.getExcelData=false
          this.$message.warning('只能上传xml/cmls格式文件')
          return false
        }
      },
      indexWarn: function (file, fileList) {
        this.$message.warning('数量已达上限！')
      },
      selectExcel: function () {

      },
      submitForm: function (formName) {
        this.$refs[formName].validate(valid => {
          if (valid) {
            this.company2.cjmz = this.company.name
            this.company2.cjdz = this.company.address
            this.company2.cjdh = this.company.phone
            this.company2.cjzfs = this.company.score
            this.company2.cjr = this.company.createBy
            this.company2.cjfr = this.company.legalPerson
            this.company2.bz = this.company.remark
            let url = ''
            this.imagePath.forEach(item => {
              url += item
              url += ','
            })
            this.company.url = url
            this.company2.cjzp = this.company.url
            if (this.imagePath.length == 3) {
              API.addNewCompany(this.company2).then(res => {
                if (res.code == 0) {
                  this.$message.success('添加成功')
                  this.resetForm('company')
                } else {
                  this.$message.error('添加失败')
                }
                this.imagePath = []
                this.fileList = []
                this.$refs['upload'].clearFiles()
              })
            } else {
              this.$message({type: 'warning', message: '照片需要上传三张'})
            }
          } else {
            this.$message({type: 'warning', message: '表格数据不完善'})
          }
        })
      },
      submitUpload: function () {
        this.$refs.upload.submit()
        console.info(this.imagePath)
      },
      handleBeforeRemove: function (file, fileList) {
        if (fileList.length == 0) {
          this.uploadKey = false
        }
        for (let j = 0, l = fileList.length; j < l; j++) {
          if (file == fileList[j]) {
            if (this.fileList.length > j) {
              this.fileList.splice(j, 1)
              console.info(this.fileList.length)
              API.removeCompanyImage({fileName: this.imagePath[j]}).then(res => {
                if (res.path) {
                  for (let i = 0, k = this.imagePath.length; i < k; i++) {
                    if (this.imagePath[i] == res.path) {
                      this.imagePath.splice(i, 1)
                      this.$message.success('删除上传照片成功')
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
      handlePreview: function (file) {
        console.log(file)
      },
      beforeUploadImage: function (file) {
        const imgReg = /^([\u2E80-\u9FFFa-zA-Z0-9\(\)_-]+.)+(png|jpg)$/
        const isLt2M = file.size / 1024 / 1024 < 5
        if (!isLt2M) {
          this.$message({
            message: '上传文件大小不能超过 5MB!',
            type: 'warning'
          })
          return false
        } else if (!imgReg.test(file.name)) {
          this.$message({
            message: '上传文件只能是 jpg、png!',
            type: 'warning'
          })
          return false
        }
        this.fileList.push(file)
        return true
      },
      uploadSuccess: function (res) {
        if (res.code === 0) {
          this.$message({
            message: '上传成功!',
            type: 'success'
          })
        }
        this.imagePath.push(res.path)
      },
      uploadExcelSuccess: function (res) {
        if (res.code === 0) {
          this.insertKey = true
          this.$message({
            message: '录入成功!',
            type: 'success'
          })
          // this.excelPath.push(res.path)
        } else {
          this.$message.error('上传失败')
        }
        this.getExcelData=false
        this.excelList = []
        this.excelPath = []
      },
      resetForm: function (formName) {
        this.$refs[formName].resetFields()
      }
    }
  }
</script>

<style scoped>
  #content_div {
    margin-top: 30px;
  }

  .form_input {
    width: 20%;
    max-width: 240px;
  }
</style>
