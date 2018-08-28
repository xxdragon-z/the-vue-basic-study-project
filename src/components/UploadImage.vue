<template>
  <el-upload
    ref="upload"
    :action="action"
    multiple
    :limit="30"
    accept="image/jpg"
    :before-upload="this.beforeUploadImage"
    :onSuccess="this.uploadSuccess"
    :on-change="handleChange"
    :before-remove="handleRemove"
    list-type="picture-card"
    :imagePath="moreImageList"
    :auto-upload="false">
    <el-button slot="trigger" size="small" type="primary">选取照片</el-button>
    <el-button style="margin-left: 10px;" size="small" type="success" @click="submitUpload" :disabled="!uploadMoreKey">批量上传照片</el-button>
    <el-button size="small" type="warning" @click="clearFile">清空列表</el-button>
    <div slot="tip" class="el-upload__tip">最大上限30张，且每张大小不超过5mb</div>

  </el-upload>
</template>
<script>
  export default {
    name: 'UploadForMoreImage',
    data () {
      return {
        fileList: [],
        moreImageList: [],
        uploadMoreKey: false
      }
    },
    props: {
      action: String
    },
    methods: {
      clearFile: function () {
        this.$refs['upload'].clearFiles()
      },
      handleRemove: function (file, fileList) {
        if (fileList.length > 0) { this.uploadMoreKey = true } else { this.uploadMoreKey = false }
      },
      handleChange: function (file, fileList) {
        if (fileList.length > 0) { this.uploadMoreKey = true } else { this.uploadMoreKey = false }
      },
      uploadSuccess: function (res) {
        if (res.code === 0) {
          this.uploadMoreKey = false
          this.$message.success('上传成功')
          this.moreImageList.push(res.path)
        } else {
          this.$message.error('出错了')
        }
      },
      submitUpload: function () {
        this.$refs.upload.submit()
        // this.$emit('change', this.imagesPath)
      },
      beforeUploadImage: function (file) {
        const isLt2M = file.size / 1024 / 1024 < 5
        if (!isLt2M) { return false }
        this.fileList.push(file)
        return true
      }
    }
  }
</script>

<style scoped>

</style>
