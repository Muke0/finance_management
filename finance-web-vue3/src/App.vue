<template>
  <el-menu default-active="1" class="sidebar">
    <div class="title">
      财务管理系统
    </div>
    <el-sub-menu index="1">
      <template #title>
        <el-icon>
          <Menu />
        </el-icon>
        <span class="menu">工资管理</span>
      </template>
      <el-menu-item index="1-1" class="menu-item" @click="toTarget('/upload')">数据上报</el-menu-item>
      <el-menu-item index="1-2" class="menu-item" @click="toTarget('/review')">数据审核</el-menu-item>
      <el-menu-item index="1-3" class="menu-item" @click="toTarget('/generate')">报表查询</el-menu-item>
      <el-menu-item index="1-4" class="menu-item" @click="toTarget('/output')">数据导出</el-menu-item>
    </el-sub-menu>
  </el-menu>
  <div class="container">
    <RouterView></RouterView>
  </div>
</template>

<script>
import { RouterView } from 'vue-router';
import axios from 'axios';
import { ElMessage } from 'element-plus'
export default {
  name: 'App',
  components: {},
  data() {
    return {
      username: "获取中..."
    };
  },
  created() { },
  methods: {
    toTarget(target) {
      this.$router.push(target);
    }
  },
  mounted() { 
    if (localStorage.getItem('token')) {
      // 获取用户信息
      axios.get('/user/info',{
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
        }
      })
    }
  },
};
</script>

<style scoped>
.sidebar {
  width: 200px;
  overflow: auto;
}

.title {
  font-size: 24px;
  font-weight: bold;
  text-align: center;
  margin: 20px 0;
}

.menu {
  font-weight: bold;
  font-size: 18px;
}

.menu-item {
  font-size: 16px;
}

.container {
  width: 100%;
}


</style>
