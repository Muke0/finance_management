const mysql = require('mysql')

const db = mysql.createPool({
    connectionLimit: 20,
    host: '43.142.182.70',
    port: 3306,
    user: 'root',
    password: 'zhaokedi',
    database: 'software_engineering',
})

module.exports = db