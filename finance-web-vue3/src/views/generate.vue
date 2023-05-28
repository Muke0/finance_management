<template>
    <headbar></headbar>
    <div class="card">
        <div class="title">工资查询</div>
        <el-form :inline="true" :model="form">
            <el-form-item label="职工ID">
                <el-input v-model="form.user" placeholder="ID" />
            </el-form-item>
            <el-form-item label="月份">
                <el-date-picker type="month" placeholder="月份" v-model="form.time" />
            </el-form-item>
            <el-form-item>
                <el-button type="primary" @click="onSubmit">Query</el-button>
            </el-form-item>
        </el-form>
        <el-row>
            <el-col :span="6">
                <el-statistic title="基础工资" :value=data.basePay />
            </el-col>
            <el-col :span="6">
                <el-statistic title="生活补贴" :value=data.livingAllowance />
            </el-col>
            <el-col :span="6">
                <el-statistic title="书本费" :value=data.bookFee />
            </el-col>
            <el-col :span="6">
                <el-statistic title="路费" :value=data.carFare />
            </el-col>
        </el-row>
        <el-row>
            <el-col :span="6">
                <el-statistic title="洗理费" :value=data.cleaningFee />
            </el-col>
            <el-col :span="6">
                <el-statistic title="课时费" :value=data.classfee />
            </el-col>
            <el-col :span="6">
                <el-statistic title="岗位津贴" :value=data.jobsubsidy />
            </el-col>
            <el-col :span="6">
                <el-statistic title="工资总额" :value=data.totalWage />
            </el-col>
        </el-row>
        <el-row>
            <el-col :span="6">
                <el-statistic title="个人所得税" :value=data.individualIncomeTax />
            </el-col>
            <el-col :span="6">
                <el-statistic title="住房公积金" :value=data.housingProvidentFund />
            </el-col>
            <el-col :span="6">
                <el-statistic title="保险费" :value=data.premium />
            </el-col>
            <el-col :span="6">
                <el-statistic title="实发工资" :value=data.netPayroll />
            </el-col>
        </el-row>
    </div>
    <div class="card">
        <div class="title">工资分析</div>
        <div class="charts" id="charts">
            <div id="chart1"></div>
        </div>
    </div>
</template>

<script>
import axios from "axios";
import * as echarts from "echarts";
export default {
    data() {
        return {
            form: {
                user: '',
                time: ''
            },
            data: {
                "wId": 1,
                "sId": 100001,
                "year": 2023,
                "month": 1,
                "basePay": 'N/A',
                "livingAllowance": 'N/A',
                "bookFee": 'N/A',
                "carFare": 'N/A',
                "cleaningFee": 'N/A',
                "classfee": 'N/A',
                "jobsubsidy": 'N/A',
                "totalWage": 'N/A',
                "individualIncomeTax": 'N/A',
                "housingProvidentFund": 'N/A',
                "premium": 'N/A',
                "netPayroll": 'N/A'
            },
            chart1_d: null,
            chart1: {
                title: {
                    text: '工资构成',
                    subtext: '',
                    left: 'center'
                },
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical',
                    left: 'right'
                },
                series: [
                    {
                        name: '类型',
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
        }
    },
    methods: {
        onSubmit() {
            console.log(this.form)
            var data = {
                sId: String(this.form.user),
                year: String(new Date(this.form.time).getFullYear()),
                month: String(new Date(this.form.time).getMonth()),
            }

            var config = {
                method: 'get',
                url: `http://43.142.182.70:9998/pay/paysheet_detail?sId=${data.sId}&year=${data.year}&month=${Number(data.month) + 1}`,
                headers: {
                    'Authorization': localStorage.getItem('token'),
                },
            };
            const _this = this
            axios(config).then(function (response) {
                console.log(response.data)
                if (response.data.length == 0 || response.data[0].basePay == null) {
                    ElMessage({
                        message: '该员工该月份无工资信息',
                        type: 'warning'
                    });
                    return
                }
                _this.data = response.data[0]
                
            }).catch(function (error) {
                console.log(error);
            })

        }
    },
    watch: {
        data: {
            handler: function (val, oldVal) {
                const domMap = document.getElementById("chart1");
                domMap.removeAttribute("_echarts_instance_");

                this.chart1_d = echarts.init(document.getElementById('chart1'))
                // 设置图表数据
                this.chart1.series[0].data = [
                    { value: this.data.basePay, name: '基础工资' },
                    { value: this.data.livingAllowance, name: '生活补贴' },
                    { value: this.data.bookFee, name: '书本费' },
                    { value: this.data.carFare, name: '路费' },
                    { value: this.data.cleaningFee, name: '洗理费' },
                    { value: this.data.classfee, name: '课时费' },
                    { value: this.data.jobsubsidy, name: '岗位津贴' },
                ]

                // 渲染图表
                this.chart1_d.setOption(this.chart1)



            },
            deep: true
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