// 导入数据库操作模块
const db = require('../db/index')
    // 导入全局的配置文件
const config = require('../config')

//获取工资表的处理函数
exports.get_paysheet = (req, res) => {
    // 获取客户端提交到服务器的用户信息
    const table = req.query
        // 定义 SQL 语句，查询用户名是否被占用
    const sqlStr = 'select sId,sName,year,month,netPayroll from wagetable where sId=? and year=? and month=?'
    db.query(sqlStr, [table.sId, table.year, table.month], (err, results) => {
        // 执行 SQL 语句失败
        if (err) {
            return res.cc(err)
        }
        res.send(results)
    })
}
exports.get_paysheet_detail = (req, res) => {
    // 获取客户端提交到服务器的用户信息
    const table = req.query
        // 定义 SQL 语句，查询用户名是否被占用
    const sqlStr = 'select * from wagetable where sId=? and year=? and month=?'
    db.query(sqlStr, [table.sId, table.year, table.month], (err, results) => {
        // 执行 SQL 语句失败
        if (err) {
            return res.cc(err)
        }
        res.send(results)
    })
}