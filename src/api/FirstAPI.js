import * as API from './axiosAPI'
export default {
  getRequest:(url,params)=>{
    return API.getRequest(url,params)
  }
}
