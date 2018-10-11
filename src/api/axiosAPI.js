import axios from 'axios'
axios.defaults.withCredentials = true
// let base='/'
export const getRequest = (url) => {
  console.info(url)
    return axios.get(url).then(result => result.data)
  }

export const PUT = (url, params) => {
  return axios.put(url, params).then(res => res.data)
}

export const DELETE = (url, params) => {
  return axios.delete(url, {params: params}).then(res => res.data)
}

export const PATCH = (url, params) => {
  return axios.patch(url, params).then(res => res.data)
}
export const POST = (url, params) => {
  console.info(url + '++++++++' + params)
  return axios.post(url, params).then(res => res.data)
}



