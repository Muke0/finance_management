/* eslint-disable indent */
import request from '@/utils/request'
// import da from 'element-ui/src/locale/lang/da'
export function getBusinessPages(page, size) {
    return request({
        url: '/business/page',
        method: 'post',
        data: {
            'page': page,
            'size': size
        }
    })
}

export function addBusiness(data) {
    return request({
        url: '/business/add',
        method: 'post',
        data: data
    })
}

export function updateBusiness(data) {
    return request({
        url: '/business/update',
        method: 'post',
        data: data
    })
}
export function delBusiness(id) {
    return request({
        url: '/business/del?id=' + id,
        method: 'get'
    })
}