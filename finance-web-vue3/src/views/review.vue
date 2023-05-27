<template>
    <headbar></headbar>

    <div class="card">
        <div class="title">审核分析</div>
        <div class="charts" id="charts">
            <div id="chart1"></div>
            <div id="chart2"></div>
        </div>

    </div>

    <div class="card">
        <div class="title">数据审核</div>
        <el-form :inline="true" :model="formInline" class="demo-form-inline">
            <el-form-item label="状态筛选">
                <el-select v-model="status" class="m-2" placeholder="状态">
                    <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value" />
                </el-select>
            </el-form-item>
        </el-form>
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
            <el-table-column fixed="right" label="操作" width="160">
                <template #default="scope">
                    <el-button link type="primary" @click="handleClick(scope.$index, scope.row)">通过</el-button>
                    <el-button link type="primary" @click="rejectClick(scope.$index, scope.row)">驳回</el-button>
                    <el-button link type="primary" @click="deleteClick(scope.$index, scope.row)">
                        <el-icon>
                            <Delete />
                        </el-icon>
                    </el-button>
                </template>
            </el-table-column>
        </el-table>
        <div style="text-align: center;">
            <el-pagination layout="prev, pager, next" :total="10" style="margin: 0 auto; width:200px;" />
        </div>

    </div>
</template>

<script>
import axios from "axios"
import * as echarts from 'echarts';
export default {
    name: "review",
    data() {
        return {
            tableData: [],
            status: '',
            options: [
                {
                    value: "全部",
                    label: "全部"
                }, {
                    value: "待审核",
                    label: "待审核"
                },
                {
                    value: "已通过",
                    label: "已通过"
                },
                {
                    value: "已驳回",
                    label: "已驳回"
                },

            ],
            chart1_d: null,
            chart1: {
                title: {
                    text: '审核状态总览',
                    subtext: '当前数据的审批状况',
                    left: 'center'
                },
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical',
                    left: 'left'
                },
                color: ['#5470c6', '#fac858'],
                series: [
                    {
                        name: 'Access From',
                        type: 'pie',
                        radius: '50%',
                        data: [
                            { value: 1048, name: '已审核' },
                            { value: 735, name: '未审核' },
                        ],
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            },
            chart2: {
                title: {
                    text: '数据审核总览',
                    subtext: '当前已审批的数据状态',
                    left: 'center'
                },
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical',
                    left: 'right'
                },
                color: ['#91cc75', '#ee6666', '#fac858'],
                series: [
                    {
                        name: 'Access From',
                        type: 'pie',
                        radius: '50%',
                        data: [
                            { value: 1048, name: '已通过' },
                            { value: 735, name: '已驳回' },
                            { value: 8, name: '未审核' },
                        ],
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            },
            tableData1: []
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
                            _this.fixChart(response.data)
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
                            _this.fixChart(response.data)

                        })
                        .catch(function (error) {
                            console.log(error);
                        });
                })
                .catch(function (error) {
                    console.log(error);
                });

        },
        deleteClick(index, row) {
            // 发送审核删除请求


            console.log(index, row)
            const _this = this

            var data = {
                sId: String(row.sId),
                year: row.time.split('-')[0],
                month: row.time.split('-')[1],
                checked: String(1)
            }

            var config = {
                method: 'delete',
                url: 'http://43.142.182.70:9998/task/',
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
                                _this.fixChart(response.data)
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
        fixChart(data) {
            // 修改图表数据，data为重新请求后的数据
            console.log(data)
            // 统计已审核和未审核的数据
            var checked = 0
            var unchecked = 0
            data.forEach((item) => {
                if (item.checked >= 1) {
                    checked += 1
                } else if (item.checked == 0) {
                    unchecked += 1
                }
            })

            // 修改图表数据
            this.chart1_d.setOption({
                series: [{
                    data: [{
                        value: checked,
                        name: '已审核'
                    }, {
                        value: unchecked,
                        name: '未审核'
                    }]
                }]
            })

            // 统计各种状态
            var status = {
                '已通过': 0,
                '待审核': 0,
                '已驳回': 0
            }

            data.forEach((item) => {
                if (item.checked == 1) {
                    status['已通过'] += 1
                } else if (item.checked == 0) {
                    status['待审核'] += 1
                } else {
                    status['已驳回'] += 1
                }
            })

            // 修改图表数据
            this.chart2_d.setOption({
                series: [{
                    data: [{
                        value: status['已通过'],
                        name: '已通过'
                    }, {
                        value: status['已驳回'],
                        name: '已驳回'
                    }, {
                        value: status['待审核'],
                        name: '待审核'
                    },]
                }]
            })


        },
    },
    mounted() {

        const domMap = document.getElementById("chart1");
        domMap.removeAttribute("_echarts_instance_");
        const domMap2 = document.getElementById("chart2");
        domMap2.removeAttribute("_echarts_instance_");

        this.chart1_d = echarts.init(document.getElementById('chart1'))
        this.chart2_d = echarts.init(document.getElementById('chart2'))


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
                    _this.tableData1.push(t_data)
                })


                _this.chart1_d.setOption(_this.chart1);
                _this.chart2_d.setOption(_this.chart2);
                _this.fixChart(response.data)
            })
            .catch(function (error) {
                console.log(error);
            });
    },
    watch: {
        status: {
            handler: function (val, oldVal) {
                //修改表格展示的数据
                if (val == "已通过") {
                    this.tableData = [];
                    this.tableData = this.tableData1.filter((item) => {
                        return item.status == "已通过";
                    });
                } else if (val == "待审核") {
                    this.tableData = [];
                    this.tableData = this.tableData1.filter((item) => {
                        return item.status == "待审核";
                    });
                } else if (val == "已驳回") {
                    this.tableData = [];
                    this.tableData = this.tableData1.filter((item) => {
                        return item.status == "已驳回";
                    });
                } else {
                    this.tableData = [];
                    this.tableData = this.tableData1;
                }
            },
        }
    }
}
</script>

<style scoped>
#chart1 {
    width: 50%;
    height: 400px;
}

#chart2 {
    width: 50%;
    height: 400px;
}

.charts {
    display: flex;
    justify-content: space-around;
}
</style>