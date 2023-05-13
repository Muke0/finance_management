const mysql = require('mysql')

const db = mysql.createPool({
    connectionLimit: 20,
    host: '',
    port: 3306,
    user: 'root',
    password: '',
    database: 'software_engineering',
})

module.exports = db
