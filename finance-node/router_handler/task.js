// 导入数据库操作模块
const db = require('../db/index')

// 导入全局的配置文件
const config = require('../config')

// 上传课时表的处理函数
exports.upload = (req, res) => {
        // 获取客户端提交到服务器的课时表
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
        var times;
        if (err) {
            return res.cc(err)
        }
        if (table.checked == 2) {
            const sql_deleteWageTable = 'delete from wagetable where sId=? and year=? and month=?'
            db.query(sql_deleteWageTable, [table.sId, table.year, table.month], (err, results) => {
                // 执行 SQL 语句失败
                if (err) {
                    return res.cc(err)
                }
                console.log('工资删除成功')
                console.log(results)
            })
        }
        if (table.checked == 1) {
            const sql_searchTimes = 'select hours from workhours where sId=? and year=? and month=?'
            db.query(sql_searchTimes, [table.sId, table.year, table.month], (err, results) => {
                // 执行 SQL 语句失败
                if (err) {
                    return res.cc(err)
                }
                times = results[0].hours;
                console.log(times)
            })
            const sql_searchPosition = 'select sPosition from staff where sId=?'
            db.query(sql_searchPosition, table.sId, (err, results) => {
                // 执行 SQL 语句失败
                if (err) {
                    return res.cc(err)
                }
                if (results[0].sPosition == '助教' || results[0].sPosition == '保卫科工作人员' || results[0].sPosition == '食堂工作人员' || results[0].sPosition == '寝室楼工作人员') {
                    var basepay = 4000;
                    var livingAllowance = 1000;
                    var bookFee = 200;
                    var carfare = 200;
                    var cleaningFee = 100;
                    var classfee = times * 50;
                    var jobsubsidy = 200;
                    var totalWage = basepay + livingAllowance + bookFee + carfare + cleaningFee + classfee + jobsubsidy;
                    var individualIncomeTax = (totalWage - 5000) * 0.03;
                    var housingProvidentFund = 1000;
                    var premium = 200;
                    var netPayroll = totalWage - individualIncomeTax - housingProvidentFund - premium;
                }
                if (results[0].sPosition == '讲师') {
                    var basepay = 5000;
                    var livingAllowance = 1000;
                    var bookFee = 200;
                    var carfare = 200;
                    var cleaningFee = 100;
                    var classfee = times * 60;
                    var jobsubsidy = 300;
                    var totalWage = basepay + livingAllowance + bookFee + carfare + cleaningFee + classfee + jobsubsidy;
                    var individualIncomeTax = (totalWage - 5000) * 0.03;
                    var housingProvidentFund = 1500;
                    var premium = 200;
                    var netPayroll = totalWage - individualIncomeTax - housingProvidentFund - premium;
                }
                if (results[0].sPosition == '副教授') {
                    var basepay = 7000;
                    var livingAllowance = 1000;
                    var bookFee = 200;
                    var carfare = 200;
                    var cleaningFee = 100;
                    var classfee = times * 80;
                    var jobsubsidy = 400;
                    var totalWage = basepay + livingAllowance + bookFee + carfare + cleaningFee + classfee + jobsubsidy;
                    var individualIncomeTax = (totalWage - 5000) * 0.03;
                    var housingProvidentFund = 2000;
                    var premium = 200;
                    var netPayroll = totalWage - individualIncomeTax - housingProvidentFund - premium;
                }
                if (results[0].sPosition == '教授') {
                    var basepay = 10000;
                    var livingAllowance = 1000;
                    var bookFee = 200;
                    var carfare = 200;
                    var cleaningFee = 100;
                    var classfee = times * 100;
                    var jobsubsidy = 500;
                    var totalWage = basepay + livingAllowance + bookFee + carfare + cleaningFee + classfee + jobsubsidy;
                    var individualIncomeTax = (totalWage - 5000) * 0.03;
                    var housingProvidentFund = 2500;
                    var premium = 200;
                    var netPayroll = totalWage - individualIncomeTax - housingProvidentFund - premium;
                }
                const sql_insertWageTable = 'insert into wagetable(sId,year,month,basePay,livingAllowance,bookFee,carfare,cleaningFee,classfee,jobsubsidy,totalWage,individualIncomeTax,housingProvidentFund,premium,netPayroll) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)'
                db.query(sql_insertWageTable, [table.sId, table.year, table.month, basepay, livingAllowance,
                    bookFee, carfare, cleaningFee, classfee, jobsubsidy, totalWage, individualIncomeTax,
                    housingProvidentFund, premium, netPayroll
                ], (err, results) => {
                    // 执行 SQL 语句失败
                    if (err) {
                        return res.cc(err)
                    }
                    console.log('工资生成成功')
                })
            })
        }
        if (table.checked == 1) {
            res.cc('审核成功！该审核通过', 0)
        }
        if (table.checked == 2) {
            res.cc('审核成功！该审核驳回', 0)
        }
    })
}

//获取课时工时表的处理函数
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

//删除课时工时表的处理函数
exports.delete_tasks = (req, res) => {
    sId = req.body.sId;
    year = req.body.year;
    month = req.body.month;
    db.getConnection((err, conn) => {
        if (err) {
            console.log(err)
        } else {
            const sql = 'delete from workhours where sId=? and year=? and month=?';
            conn.query(sql, [sId, year, month], (err, result) => {
                if (err) {
                    console.log(err);
                } else {
                    if (result.affectedRows == 0) {
                        res.cc("不存在该任务表", 1);
                    } else {
                        res.cc("删除成功", 0)
                    }
                    conn.release();
                }
            })
        }
    })
}