<template>
  <el-row>
    <el-col :span="22" :offset="1" style="margin-top: 20px;">
      <el-card class="box-card">
        <div slot="header" class="clearfix">
          <span>员工工资</span>
        </div>
        <el-row>
          <el-col style="margin-top: 15px;"><label>员工:</label>{{userInfo.name}}</el-col>
          <el-col style="margin-top: 15px;"><label>员工编号:</label>{{userInfo.number}}</el-col>
          <el-col style="margin-top: 15px;"><label>员工住址:</label>{{userInfo.address}}</el-col>
          <el-col style="margin-top: 15px;"><label>员工手机:</label>{{userInfo.phone}}</el-col>
          <el-col style="margin-top: 15px;"><label>员工邮箱:</label>{{userInfo.email}}</el-col>
          <el-col style="margin-top: 15px;"><label>员工银行卡号:</label>{{userInfo.bankNumber}}</el-col>
          <el-col style="margin-top: 15px;"><label>员工部门:</label>{{userInfo.department.name}}</el-col>
          <el-col style="margin-top: 15px;"><label>员工部门描述:</label>{{userInfo.department.note}}</el-col>
          <el-col style="margin-top: 15px;"><label>员工部门工资:</label>{{userInfo.department.money}}</el-col>
          <el-col style="margin-top: 15px;"><label>员工部门业务奖金:</label>{{userInfo.department.businessAmount}}</el-col>
        </el-row>
      </el-card>
    </el-col>
  </el-row>
</template>

<script>
  import {getUserInfo} from '@/api/user'

  export default {
    name: 'User',
    data(){
      return{
        userInfo:{}
      }
    },
    mounted(){
      this.getUserInfo();
    },
    methods: {
      getUserInfo() {
        getUserInfo().then(response => {
          const { data } = response
          this.userInfo = data;
          console.log("获取用户")
        }).catch(error => {
          this.$message({
            message: error,
            type: "error"
          });
        });
      },
    }
  }
</script>

<style scoped>

</style>
