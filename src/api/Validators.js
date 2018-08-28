// noinspection JSAnnotator
export default {
  notNull: (rule, value, callback) => {
    if (!value) {
      return callback(new Error('不可为空'))
    } else {
      return callback()
    }
  },
  checkImagePath: (rule, value, callback) => {
    const pathReg = /^(([a-zA-Z0-9\/\\\:\-_]+)+(\.[A-Za-z]+,)){3}$/
    if (!pathReg.test(value)) {
      return callback(new Error('需要三张照片'))
    } else {
      return callback()
    }
  },
  checkphone: (rule, value, callback) => {
    const phoneReg = /^1[0-9]{10,10}$/
    const telephoneReg = /^0[0-9]{2,2}(-[0-9]{7,8})$/
    if (!phoneReg.test(value)) {
      if (!telephoneReg.test(value)) {
        return callback(new Error('请输入正确格式手机号码'))
      } else {
        return callback()
      }
    } else {
      return callback()
    }
  },
  mustNumber: (rule, value, callback) => {
    const numberReg = /^\d+$/
    if ((!numberReg.test(value)) || value <= 0) {
      return callback(new Error('请输入纯数字'))
    } else {
      return callback()
    }
  }
}
