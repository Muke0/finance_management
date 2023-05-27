// 导入数据库操作模块
const db = require('../db/index')
    // 导入全局的配置文件
const config = require('../config')

//获取工资表的处理函数
exports.get_paysheet = (req, res) => {
    // 获取客户端提交到服务器的用户信息
    const table = req.query
        // 定义 SQL 语句，查询用户名是否被占用
    const sqlStr = 'select wagetable.sId,staff.sName,wagetable.year,wagetable.month,wagetable.netPayroll from wagetable left join staff on wagetable.sId=staff.sId where wagetable.sId=? and wagetable.year=? and wagetable.month=?'
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
    const sqlStr = 'select w.sId,s.sName,w.year,w.month,w.basePay,w.livingAllowance,w.bookFee,w.carFare,w.cleaningFee,w.classfee,w.jobsubsidy,w.totalWage,w.individualIncomeTax,w.housingProvidentFund,w.premium,w.netPayroll from wagetable w left join staff s on w.sId=s.sId where w.sId=? and w.year=? and w.month=?;'
    db.query(sqlStr, [table.sId, table.year, table.month], (err, results) => {
        // 执行 SQL 语句失败
        if (err) {
            return res.cc(err)
        }
        res.send(results)
    })
}