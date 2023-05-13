// 导入数据库操作模块
const db = require('../db/index')
    // 导入 bcryptjs 这个包
const bcrypt = require('bcryptjs')
    // 导入生成 Token 的包
const jwt = require('jsonwebtoken')
    // 导入全局的配置文件
const config = require('../config')

// 上传课时表的处理函数
exports.upload = (req, res) => {
        // 获取客户端提交到服务器的用户信息
        const table = req.body
            // 定义 SQL 语句，查询用户名是否被占用
        const sqlStr = 'insert into workhours(sId,year,month,hours,checked) values(?,?,?,?,0)'
        db.query(sqlStr, [table.sId, table.year, table.month, table.times], (err, results) => {
            // 执行 SQL 语句失败
            if (err) {
                return res.cc(err)
            }
            res.cc('上传成功！', 0)
        })
    }
    // 审核的处理函数
exports.check = (req, res) => {
    // 获取客户端提交到服务器的用户信息
    const table = req.body
        // 定义 SQL 语句，查询用户名是否被占用
    const sqlStr = 'update workhours set checked=? where sId=? and year=? and month=?'
    db.query(sqlStr, [table.checked, table.sId, table.year, table.month, table.times], (err, results) => {
        // 执行 SQL 语句失败
        if (err) {
            return res.cc(err)
        }
        res.cc('审核成功！', 0)
    })
}
exports.get_tasks = (req, res) => {
    page = req.query.page || 0;
    size = req.query.size || 30;
    db.getConnection((err, conn) => {
        if (err) {
            console.log(err)
        } else {
            const sql = 'select * from workhours limit ' + page + ',' + size;
            conn.query(sql, (err, result) => {
                if (err) {
                    console.log(err);
                } else {
                    res.json(result)
                    conn.release();
                }
            })
        }
    })
}