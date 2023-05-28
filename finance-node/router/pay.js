const express = require('express')
const router = express.Router()

// 导入工资表路由处理函数对应的模块
const pay_handler = require('../router_handler/pay')

//获取工资表
router.get('/paysheet', pay_handler.get_paysheet)

//获取工资明细表
router.get('/paysheet_detail', pay_handler.get_paysheet_detail)
module.exports = router