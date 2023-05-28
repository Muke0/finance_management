<template>
    <headbar></headbar>
    <div class="card">
        <div class="title">报表导出</div>



        <el-form :model="form" label-width="120px" style="width:60%;margin" label-position="left">
            <el-form-item label="日期">
                <el-col :span="11">
                    <el-date-picker v-model="form.date" type="month" placeholder="日期" style="width: 100%" />
                </el-col>
            </el-form-item>
            <el-form-item label="导出类型">
                <el-checkbox-group v-model="form.type">
                    <el-checkbox label="工资报表" name="type" />
                    <el-checkbox label="工资明细" name="type" />
                </el-checkbox-group>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" @click="onSubmit">导出</el-button>
            </el-form-item>
        </el-form>

        <el-table :data="tableData" stripe style="width: 100%" @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55" />
            <el-table-column prop="sId" label="教职工ID" width="180" />
            <el-table-column prop="sName" label="姓名" width="180" />
            <el-table-column prop="sPosition" label="职称" />
            <el-table-column prop="sType" label="类别" />
        </el-table>
        <div style="text-align: center;">
            <el-pagination layout="prev, pager, next" :total="10" style="margin: 0 auto; width:200px;"/>
        </div>
    </div>
</template>

<script>
import axios from 'axios';
export default {
    name: "review",
    data() {
        return {
            tableData: [],
            form: {
                date: new Date(),
                type: [],
            },
            selected: [],
            total: 0,
            // 工资表
            has_total: 0,
            preData: [],

            // 工资明细表
            has_total_more: 0,
            preData_more: [],

        }
    },
    mounted() {
        var config = {
            method: 'get',
            url: 'http://43.142.182.70:9998/staff/',
            headers: {
                'Authorization': localStorage.getItem('token'),
            },
        };
        const _this = this
        axios(config)
            .then(function (response) {
                console.log(response.data)
                response.data.forEach((data) => {
                    _this.tableData.push(data)
                })
            })
            .catch(function (error) {
                console.log(error);
            });
    },
    methods: {
        handleSelectionChange(val) {
            this.selected = val
        },
        onSubmit() {
            // 获取element-plus表格选中的行
            var selected = this.selected
            if (selected.length == 0) {
                ElMessage({
                    message: '请选择教职工',
                    type: 'warning',
                })
                return
            }

            this.total = selected.length

            // 获取导出类型
            var type = ''
            if (this.form.type.length == 2) {
                type = '1'
            } else if (this.form.type.length == 1) {
                type = this.form.type[0]
            } else {
                ElMessage({
                    message: '请选择导出类型',
                    type: 'warning',
                })
                return
            }



            console.log(selected)

            ElMessage({
                message: '开始导出，请稍后...',
                type: 'success',
            })


            // 发送请求
            if (type == '1' || type == '工资报表') {

                const _this = this
                for (var i = 0; i < selected.length; i++) {
                    var config = {
                        method: 'get',
                        url: 'http://43.142.182.70:9998/pay/paysheet',
                        headers: {
                            'Authorization': localStorage.getItem('token'),
                        },
                        params: {
                            'sId': selected[i].sId,
                            'year': String(new Date(this.form.date).getFullYear()),
                            'month': String(new Date(this.form.date).getMonth()) + 1,
                        }
                    };

                    const _this = this

                    axios(config)
                        .then(function (response) {
                            console.log(response.data)
                            _this.has_total += 1
                            if (response.data.length != 0) {
                                _this.preData.push({
                                    "教职工编号": response.data[0].sId,
                                    "教职工姓名": response.data[0].sName,
                                    "年份": response.data[0].year,
                                    "月份": response.data[0].month,
                                    "实发工资": response.data[0].netPayroll,
                                })
                            }
                        })
                        .catch(function (error) {
                            console.log(error);
                            _this.has_total += 1
                        });
                }
            }

            if (type == '1' || type == '工资明细') {
                const _this = this
                for (var i = 0; i < selected.length; i++) {
                    var config = {
                        method: 'get',
                        url: 'http://43.142.182.70:9998/pay/paysheet_detail',
                        headers: {
                            'Authorization': localStorage.getItem('token'),
                        },
                        params: {
                            'sId': selected[i].sId,
                            'year': String(new Date(this.form.date).getFullYear()),
                            'month': String(new Date(this.form.date).getMonth()) + 1,
                        }
                    };

                    const _this = this

                    axios(config)
                        .then(function (response) {
                            console.log(response.data)
                            _this.has_total_more += 1
                            if (response.data.length != 0) {
                                _this.preData_more.push({
                                    "教职工编号": response.data[0].sId,
                                    "教职工姓名": response.data[0].sName,
                                    "年份": response.data[0].year,
                                    "月份": response.data[0].month,
                                    "基本工资": response.data[0].basePay,
                                    "书报费": response.data[0].bookFee,
                                    "交通费": response.data[0].carFare,
                                    "洗理费": response.data[0].cleanFee,
                                    "住房公积金": response.data[0].housingProvidentFund,
                                    "个人所得税": response.data[0].individualIncomeTax,
                                    "岗位津贴": response.data[0].jobsubsidy,
                                    "生活补贴": response.data[0].livingAllowance,
                                    "工资总额": response.data[0].totalWage,
                                    "实发工资": response.data[0].netPayroll,
                                })
                            }
                        })
                        .catch(function (error) {
                            console.log(error);
                            _this.has_total_more += 1
                        });
                }
            }
        }
    },
    watch: {
        has_total: function (val) {
            if (val == this.total) {
                ElMessage({
                    message: '正在导出，请稍后...',
                    type: 'success',
                })
                var workbook = XLSX.utils.book_new();
                var worksheet = XLSX.utils.json_to_sheet(this.preData);
                XLSX.utils.book_append_sheet(workbook, worksheet, "SheetJS");


                XLSX.writeFile(workbook, '工资报表.xlsx');

                this.has_total = 0;
                this.preData = [];

            }
        },
        has_total_more: function (val) {
            if (val == this.total) {
                ElMessage({
                    message: '正在导出，请稍后...',
                    type: 'success',
                })
                var workbook = XLSX.utils.book_new();
                var worksheet = XLSX.utils.json_to_sheet(this.preData_more);
                XLSX.utils.book_append_sheet(workbook, worksheet, "SheetJS");


                XLSX.writeFile(workbook, '工资明细表.xlsx');

                this.has_total_more = 0;
                this.preData_more = [];

            }
        }
    }
}
</script>