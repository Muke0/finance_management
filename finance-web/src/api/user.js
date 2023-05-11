import request from '@/utils/request'
import da from 'element-ui/src/locale/lang/da'

export function login(data) {
  return request({
    url: '/user/login',
    method: 'post',
    data
  })
}

export function getInfo(token) {
  return request({
    url: '/user/info',
    method: 'get',
    params: { token }
  })
}

export function logout() {
  return request({
    url: '/user/logout',
    method: 'post'
  })
}


export function getMenus() {
  return new Promise((resolve, reject) => {
    request({
      url: '/menu/menus',
      method: 'get'
    }).then(response => {
      const { data } = response
      resolve(data)
    }).catch(error => {
      reject(error)
    })
  })
}


export function getUserInfo() {
  return request({
    url: '/user/info',
    method: 'get',
  });
}

export function updatePassword(data) {
  return request({
    url: '/user/updatePassword',
    method: 'post',
    data:data
  });
}

export function updateUser(data) {
  return request({
    url: '/user/updateInfo',
    method: 'post',
    data:data
  });
}

export function updateUser2(data) {
  return request({
    url: '/user/update',
    method: 'post',
    data:data
  });
}



export function getUserPages(page,size) {
  return request({
    url: '/user/page',
    method: 'post',
    data:{
      "page":page,
      "size":size,
    }
  })
}


export function addUser(data) {
  return request({
    url: '/user/add',
    method: 'post',
    data:data
  })
}

export function delUser(id) {
  return request({
    url: '/user/del?id='+id,
    method: 'get'
  })
}

