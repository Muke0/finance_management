const express = require('express')
const router = express.Router()

// 导入任务表路由处理函数对应的模块
const task_handler = require('../router_handler/task')

// 上传课时表
router.post('/upload', task_handler.upload)
    //审核课时表
router.post('/check', task_handler.check)
    //获取课时表
router.get('/', task_handler.get_tasks)
module.exports = router