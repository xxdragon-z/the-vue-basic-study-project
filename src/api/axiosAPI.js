import axios from 'axios'

axios.defaults.withCredentials = true
export const getRequest = (url, params) => {
  console.info("开始调用：url=" + url)
  if (url) {
    if (!params)
      params={"msg":null};
    return axios.get(url,{params:params}).then(result => result.data)
  }

}


