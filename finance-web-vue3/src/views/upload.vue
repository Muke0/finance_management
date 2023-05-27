<template>
    <headbar></headbar>
    <div class="card">
        <div class="title">数据上传</div>
        <el-form :label-position="'left'" label-width="100px" style="max-width: 460px" class="forms">
        <el-form-item label="教职工ID">
            <el-input v-model="form.id" />
        </el-form-item>
        <el-form-item label="时间">
            <el-date-picker type="month" placeholder="选择月份" v-model="form.time" />
        </el-form-item>
        <el-form-item label="课时数">
            <el-input v-model="form.lesson" />
        </el-form-item>
        <el-form-item label="">
            <el-button type="primary" @click="onSubmit()">
                上传
            </el-button>
        </el-form-item>
    </el-form>
    </div>
    
</template>

<script>
import axios from "axios";
export default {
    data() {
        return {
            form: {
                id: '',
                time: '',
                lesson: '',
            }
        }
    },
    methods: {
        onSubmit() {
            console.log(this.form)
            var data = {
                'sId': this.form.id,
                'year': String(new Date(this.form.time).getFullYear()),
                'month': String(new Date(this.form.time).getMonth()+1),
                'times': this.form.lesson
            };
            var config = {
                method: 'post',
                url: 'http://43.142.182.70:9998/task/upload',
                headers: {
                    'Authorization': localStorage.getItem('token'),
                },
                data: data
            };

            axios(config)
                .then(function (response) {
                    ElMessage({
                        message: '上传成功',
                        type: 'success',
                    })
                })
                .catch(function (error) {
                    console.log(error);
                });
        }
    }
}
</script>

<style scoped>
.forms {
    margin: 0 auto;
    margin-top: 10vh;
}
</style>