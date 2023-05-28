const mysql = require('mysql')

const db = mysql.createPool({
    connectionLimit: 20, //数据库最大连接数量
    host: '', //数据库地址，本机为127.0.0.1
    port: 3306, //数据库端口，默认为3306
    user: '', //数据库用户名
    password: '', //数据库密码
    database: 'software_engineering', //数据库名
})

module.exports = db