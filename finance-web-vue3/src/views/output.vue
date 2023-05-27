<template>
    <headbar></headbar>
    <div>
        <el-table :data="tableData" stripe style="width: 100%">
            <el-table-column prop="isSelect" type="selection" width="55" />
            <el-table-column prop="sId" label="教职工ID" width="180" />
            <el-table-column prop="sName" label="姓名" width="180" />
            <el-table-column prop="sPosition" label="职称" />
            <el-table-column prop="sType" label="类别" />
        </el-table>
        <el-form :model="form" label-width="120px"  style="width:60%;margin">
            <el-form-item label="Activity name">
                <el-input v-model="form.name" />
            </el-form-item>
            <el-form-item label="Activity zone">
                <el-select v-model="form.region" placeholder="please select your zone">
                    <el-option label="Zone one" value="shanghai" />
                    <el-option label="Zone two" value="beijing" />
                </el-select>
            </el-form-item>
            <el-form-item label="Activity time">
                <el-col :span="11">
                    <el-date-picker v-model="form.date1" type="date" placeholder="Pick a date" style="width: 100%" />
                </el-col>
                <el-col :span="2" class="text-center">
                    <span class="text-gray-500">-</span>
                </el-col>
                <el-col :span="11">
                    <el-time-picker v-model="form.date2" placeholder="Pick a time" style="width: 100%" />
                </el-col>
            </el-form-item>
            <el-form-item label="Instant delivery">
                <el-switch v-model="form.delivery" />
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
                name: '',
                region: '',
                date1: '',
                date2: '',
                delivery: false,
                type: [],
            }
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
                    data["isSelect"] = false
                    _this.tableData.push(data)
                })
            })
            .catch(function (error) {
                console.log(error);
            });
    }
}
</script>