<template>
    <div class="header">
        <el-dropdown>
            <el-button type="text" class="avatar-btn">
                <el-avatar src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png" /><span>{{ username
                }}</span>
            </el-button>
            <template #dropdown>
                <el-dropdown-menu>
                    <el-dropdown-item @click="logout">登出</el-dropdown-item>
                </el-dropdown-menu>
            </template>
        </el-dropdown>
    </div>
</template>

<script>
import axios from 'axios'
import { ElMessage } from 'element-plus'
export default {
    name: 'headbar',
    data() {
        return {
            username: '获取中...'
        }
    },
    methods: {
        logout() {
            localStorage.removeItem('token');
            ElMessage({
                message: '您已登出',
                type: 'warning',
            })
            this.$router.push('/login');
        }
    },
    mounted() {
        if (localStorage.getItem('token')) {
            // 获取用户信息
            axios.get('/user/info', {
                headers: {
                    Authorization: localStorage.getItem('token')
                }
            }).then(res => {
                if (res.data.user_name) {
                    this.username = res.data.user_name;
                } else {
                    ElMessage({
                        message: res.data.message,
                        type: 'error',
                    })
                    this.$router.push('/login');
                }
            }).catch(err => {
                ElMessage({
                    message: "错误",
                    type: 'error',
                })
                this.$router.push('/login');
            })
        }
    },

}

</script>

<style scoped>
.header {
    height: 60px;
    background-color: #ffffff;
    border-bottom: 1px solid #ccc;
    box-shadow: 0 0 10px #ccc;
    display: flex;
    align-items: center;
    justify-content: flex-end;
}

.avatar-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 20px;
}

.avatar-btn span {
    margin-left: 10px;
    font-size: 16px;
    font-weight: bold;
    color: #555;
}
</style>