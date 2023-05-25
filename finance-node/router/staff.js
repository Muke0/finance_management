const express = require('express')
const router = express.Router()

// 导入教职工路由处理函数对应的模块
const staff_handler = require('../router_handler/staff')

// 上传教职工信息
router.post('/', staff_handler.upload)
    //获取教职工信息
router.get('/', staff_handler.get_staff)
    //删除教职工信息
router.delete('/', staff_handler.delete_staff)
router.put('/', staff_handler.update_staff)
module.exports = router