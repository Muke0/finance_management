// 导入数据库操作模块
const db = require('../db/index')
    // 导入全局的配置文件
const config = require('../config')

// 上传教职工信息的处理函数
exports.upload = (req, res) => {
    // 获取客户端提交到服务器的用户信息
    const info = req.body
        // 定义 SQL 语句，插入教职工信息
    const sqlStr = 'insert into staff(sId,sName,sPosition,sType) values(?,?,?,?)'
    db.query(sqlStr, [info.sId, info.sName, info.sPosition, info.sType], (err, results) => {
        // 执行 SQL 语句失败
        if (err) {
            return res.cc(err)
        }
        res.cc('教职工添加成功！', 0)
    })
}

//获取教职工信息的处理函数
exports.get_staff = (req, res) => {
    page = req.query.page || 0;
    size = req.query.size || 30;
    db.getConnection((err, conn) => {
        if (err) {
            console.log(err)
        } else {
            const sql = 'select * from staff limit ' + page + ',' + size;
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

//删除教职工信息的处理函数
exports.delete_staff = (req, res) => {
    sId = req.body.sId;
    db.getConnection((err, conn) => {
        if (err) {
            console.log(err)
        } else {
            const sql = 'delete from staff where sId=?';
            conn.query(sql, [sId], (err, result) => {
                if (err) {
                    console.log(err);
                } else {
                    if (result.affectedRows == 0) {
                        res.cc("不存在该教职工", 1);
                    } else {
                        res.cc("删除成功", 0);
                    }
                    conn.release();
                }
            })
        }
    })
}

//更新教职工信息的处理函数
exports.update_staff = (req, res) => {
    const info = req.body
        // 定义 SQL 语句，更改教职工信息
    const sqlStr = 'update staff set sName=?,sPosition=?,sType=? where sId=?'
    db.query(sqlStr, [info.sName, info.sPosition, info.sType, info.sId], (err, results) => {
        // 执行 SQL 语句失败
        if (err) {
            return res.cc(err)
        }
        res.cc('教职工信息修改成功！', 0)
    })
}