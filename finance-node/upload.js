const path = require('path')
const multer = require('multer')
const mime = require('mime')

// 定义文件存储路径和文件名
const storage = multer.diskStorage({
    destination: function(req, file, cb) {
        cb(null, path.join(__dirname, './public/uploads'))
    },
    filename: function(req, file, cb) {
        // console.log('file', file);
        const arr = file.originalname.split(".");
        const ext = arr.pop();
        const filename = `${req.body.voicename}.${ext}`
        cb(null, filename);
        // console.log(arr);
    }
})

const upload = multer({
    storage
})

module.exports = upload