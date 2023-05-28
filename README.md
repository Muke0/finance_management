# 系统介绍

该系统是一个软件工程大作业。

# 技术说明

后台 nodejs,数据库 Mysql，连接池

前台 vue-cli 3.0，vue-element-ui

# 部署运行说明

在mysql数据库中运行software_engineering.sql，创建数据库

修改 finance-node/db/index.js 的数据库连接配置为自己的

在finance-node目录运行 node app.js启动后端服务

前台在finance-web-vue3目录运行 npm install 安装依赖，npm run dev 运行即可

用户名/密码 zkd / 11111111
