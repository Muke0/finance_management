<template>
    <div class="login">
        <div class="mask"></div>
        <div class="card">
            <p class="title">注册</p>
            <el-form :model="form" :rules="rules" ref="form" label-width="80px">
                <el-form-item label="用户名" prop="username">
                    <el-input v-model="form.username"></el-input>
                </el-form-item>
                <el-form-item label="密码" prop="password">
                    <el-input type="password" v-model="form.password"></el-input>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" @click="register">注册</el-button>
                    <el-link type="primary" @click="login" class="link-btn">返回登录</el-link>
                </el-form-item>
            </el-form>
        </div>
    </div>
</template>

<script>
import axios from 'axios'
import { ElMessage } from 'element-plus'
export default {
    name: 'Login',
    data() {
        return {
            form: {
                username: '',
                password: ''
            },
            rules: {
                username: [
                    { required: true, message: '请输入用户名', trigger: 'blur' },
                    { min: 3, max: 10, message: '长度在 3 到 20 个字符', trigger: 'blur' }
                ],
                password: [
                    { required: true, message: '请输入密码', trigger: 'blur' },
                    { min: 6, max: 20, message: '长度在 8 到 20 个字符', trigger: 'blur' }
                ]
            }
        }
    },
    methods: {
        login() {
            this.$router.push('/login')
        },

        register() {
            axios.post('/user/register', {
                user_name: this.form.username,
                user_password: this.form.password
            }).then(res => {
                if (res.data.status === 0) {
                    ElMessage({
                        message: '注册成功，请重新输入用户名密码进行登入',
                        type: 'success',
                    })
                    this.$router.push('/login')
                } else {
                    ElMessage({
                        message: res.data.message,
                        type: 'error',
                    })
                }
            })
        }


    }
}

</script>

<style scoped>
.link-btn {
    margin-left:32px;
}

.login {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
    height: 100vh;
    width: 100vw;
    background-color: #f5f5f5;
    z-index: 999;
    background-image: url(../bg.webp);
}

.login .title {
    font-size: 24px;
    font-weight: bold;
    text-align: center;
    margin: 20px 0;
}

.mask {
    position: absolute;
    top: 0;
    left: 0;
    height: 100vh;
    width: 100vw;
    background-color: #000;
    opacity: 0.3;
    z-index: -1;
}

.card {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    height: 300px;
    width: 300px;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 0 10px #000;
    z-index: 1;

    padding: 20px;
}
</style>