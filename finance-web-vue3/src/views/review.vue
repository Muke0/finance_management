<template>
    <headbar></headbar>
    <div>
        <el-table :data="tableData" stripe style="width: 100%">
            <el-table-column prop="sId" label="教职工ID" width="180" />
            <el-table-column prop="time" label="生效时间" width="180" />
            <el-table-column prop="hours" label="课时数" />
            <el-table-column prop="status" label="状态">
                <template #default="scope">
                    <el-tag :type="scope.row.status === '待审核' ? 'info' : scope.row.status === '已通过' ? 'success' : 'danger'"
                        disable-transitions>{{ scope.row.status
                        }}</el-tag>
                </template>
            </el-table-column>
            <el-table-column fixed="right" label="操作" width="120">
                <template #default="scope">
                    <el-button link type="primary" @click="handleClick(scope.$index, scope.row)">通过</el-button>
                    <el-button link type="primary" @click="rejectClick(scope.$index, scope.row)">驳回</el-button>
                </template>
            </el-table-column>
        </el-table>
    </div>
</template>

<script>
import axios from "axios"
export default {
    name: "review",
    data() {
        return {
            tableData: []
        }
    },
    methods: {
        rejectClick(index, row) {
            // 发送审核不通过请求


            console.log(index, row)


            var data = {
                sId: String(row.sId),
                year: row.time.split('-')[0],
                month: row.time.split('-')[1],
                checked: String(2)
            }

            var config = {
                method: 'post',
                url: 'http://43.142.182.70:9998/task/check',
                headers: {
                    'Authorization': localStorage.getItem('token'),
                },
                data: data
            };
            const _this = this
            axios(config)
                .then(function (response) {
                    var config = {
                        method: 'get',
                        url: 'http://43.142.182.70:9998/task/',
                        headers: {
                            'Authorization': localStorage.getItem('token'),
                        },
                    };

                    axios(config)
                        .then(function (response) {
                            console.log(response.data)
                            _this.tableData = [];
                            response.data.forEach((data) => {
                                const t_data = {
                                    sId: data.sId,
                                    time: data.year + '-' + data.month,
                                    hours: data.hours,
                                    status: data.checked == 1 ? '已通过' : data.checked == 0 ? '待审核' : '已驳回'
                                }
                                _this.tableData.push(t_data)
                            })
                        })
                        .catch(function (error) {
                            console.log(error);
                        });
                })
                .catch(function (error) {
                    console.log(error);
                });
        },
        handleClick(index, row) {
            // 发送审核通过请求


            console.log(index, row)
            const _this = this

            var data = {
                sId: String(row.sId),
                year: row.time.split('-')[0],
                month: row.time.split('-')[1],
                checked: String(1)
            }

            var config = {
                method: 'post',
                url: 'http://43.142.182.70:9998/task/check',
                headers: {
                    'Authorization': localStorage.getItem('token'),
                },
                data: data
            };

            axios(config)
                .then(function (response) {
                    var config = {
                        method: 'get',
                        url: 'http://43.142.182.70:9998/task/',
                        headers: {
                            'Authorization': localStorage.getItem('token'),
                        },
                    };

                    axios(config)
                        .then(function (response) {
                            console.log(response.data)
                            _this.tableData = [];
                            response.data.forEach((data) => {
                                const t_data = {
                                    sId: data.sId,
                                    time: data.year + '-' + data.month,
                                    hours: data.hours,
                                    status: data.checked == 1 ? '已通过' : data.checked == 0 ? '待审核' : '已驳回'
                                }
                                _this.tableData.push(t_data)
                            })
                        })
                        .catch(function (error) {
                            console.log(error);
                        });
                })
                .catch(function (error) {
                    console.log(error);
                });

        }
    },
    mounted() {
        var config = {
            method: 'get',
            url: 'http://43.142.182.70:9998/task/',
            headers: {
                'Authorization': localStorage.getItem('token'),
            },
        };
        const _this = this
        axios(config)
            .then(function (response) {
                console.log(response.data)

                response.data.forEach((data) => {
                    const t_data = {
                        sId: data.sId,
                        time: data.year + '-' + data.month,
                        hours: data.hours,
                        status: data.checked == 1 ? '已通过' : data.checked == 0 ? '待审核' : '已驳回'
                    }
                    _this.tableData.push(t_data)
                })
            })
            .catch(function (error) {
                console.log(error);
            });
    }
}
</script>