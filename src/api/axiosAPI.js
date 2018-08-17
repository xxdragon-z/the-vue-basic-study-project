import axios from 'axios'

axios.defaults.withCredentials = true
export const getRequest = (url, params) => {
  console.info("开始调用：url=" + url)
  if (url) {
    if (params) {
      if (params.isArray()) {
        var str = '?';
        for (var i = 0, k = params.length; i < k; i++) {
          str += params[i].name + "=" + params.value + "&"
        }
        url += str
      } else {
        url += "?" + params.name + "=" + params.value
      }
    }
    console.info("新的URL=" + url)
    return axios.get(url).then(result => result.data)
  }
}


