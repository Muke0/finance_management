<template>
    <headbar></headbar>
    <div class="desc">
        <p>你好！欢迎访问</p>
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
}

</script>

<style scoped>
.desc {
    text-align: center;
    font-size: 20px;
    margin-top: 20px;
}
</style>