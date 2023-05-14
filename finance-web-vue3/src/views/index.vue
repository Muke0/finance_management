<template>
    <headbar></headbar>
    <div>
        <p>欢迎访问</p>
        <p>学校工资管理系统</p>
    </div>
</template>

<script>
import headbar from '../components/headbar.vue'
export default {
    name: 'Index',
    components: {
        headbar
    },
    data() {
        return {
            username: '获取中...'
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