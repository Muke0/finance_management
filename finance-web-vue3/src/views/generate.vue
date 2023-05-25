<template>
    <headbar></headbar>
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
            <el-statistic title="cleaningFee" :value=data.cleaningFee />
        </el-col>
        <el-col :span="6">
            <el-statistic title="classfee" :value=data.classfee />
        </el-col>
        <el-col :span="6">
            <el-statistic title="jobsubsidy" :value=data.jobsubsidy />
        </el-col>
        <el-col :span="6">
            <el-statistic title="totalWage" :value=data.totalWage />
        </el-col>
    </el-row>
    <el-row>
        <el-col :span="6">
            <el-statistic title="个人所得税" :value=data.individualIncomeTax />
        </el-col>
        <el-col :span="6">
            <el-statistic title="housingProvidentFund" :value=data.housingProvidentFund />
        </el-col>
        <el-col :span="6">
            <el-statistic title="premium" :value=data.premium />
        </el-col>
        <el-col :span="6">
            <el-statistic title="总工资" :value=data.netPayroll />
        </el-col>
    </el-row>
</template>

<script>
import axios from "axios";
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
                "basePay": 3000,
                "livingAllowance": null,
                "bookFee": null,
                "carFare": null,
                "cleaningFee": null,
                "classfee": null,
                "jobsubsidy": null,
                "totalWage": null,
                "individualIncomeTax": null,
                "housingProvidentFund": null,
                "premium": null,
                "netPayroll": 3700
            }
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
            axios(config).then(function(response) {
                console.log(response.data)
                _this.data = response.data[0]
            }).catch(function(error) {
                console.log(error);
            })

        }
    }
}
</script>