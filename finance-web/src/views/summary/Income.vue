<template>

  <el-row style="margin-top: 20px;">
    <el-col :span="22" :offset="1">
      <el-form ref="form" :model="form" label-width="80px;">
        <el-form-item label="范围时间">
          <el-col :span="6">
            <el-date-picker type="date" placeholder="选择开始时间" v-model="form.date1" style="width: 100%;"></el-date-picker>
          </el-col>
          <el-col :span="6" style="margin-left: 10px;">
            <el-time-picker type="date"  placeholder="选择结束时间" v-model="form.date2" style="width: 100%;"></el-time-picker>
          </el-col>
          <el-col :span="6" style="margin-left: 10px;">
            <el-button type="primary" @click="onSubmit">搜索</el-button>
          </el-col>
        </el-form-item>
      </el-form>
    </el-col>
    <el-col :span="10" :offset="1">
      <el-card class="box-card">

        <div id="myChart" :style="{width: '500px', height: '300px'}"></div>
      </el-card>

    </el-col>
    <el-col :span="10" :offset="1">
      <el-card class="box-card">
        <div id="myChart2" :style="{width: '500px', height: '300px'}"></div>
      </el-card>
    </el-col>
  </el-row>

</template>

<script>
  import {getDepartmentNames} from '@/api/department';

  export default {
    name: 'Income',
    data () {
      return {
        msg: 'Welcome to Your Vue.js App',
        form:{
          date1: '',
          date2: '',
        },
        departmentNames:[],
        names:[],
        moneys:[],
        moneys2:[],
      }
    },
    mounted(){
      this.getDepartmentNames();
    },
    methods: {
      drawLine(){
        // 基于准备好的dom，初始化echarts实例
        let myChart = this.$echarts.init(document.getElementById('myChart'))
        let myChart2 = this.$echarts.init(document.getElementById('myChart2'))
        // 绘制图表
        myChart.setOption({
          title: { text: '部门收入' },
          tooltip: {},
          xAxis: {
            data: this.names
          },
          yAxis: {},
          series: [{
            name: '收入',
            type: 'bar',
            data: this.moneys
          }]
        });
        myChart2.setOption({
          title: { text: '部门支出' },
          tooltip: {},
          xAxis: {
            data: this.names
          },
          yAxis: {},
          series: [{
            name: '支出',
            type: 'bar',
            data: this.moneys2
          }]
        });
      },
      getDepartmentNames(){
        getDepartmentNames().then(response => {
          this.departmentNames = response.data;
          let names = [];
          let moneys = [];
          let moneys2 = [];
          for(let i=0;i<response.data.length;i++){
            let d = response.data[i];
            names.push(d["name"])
            moneys.push(d["money"])
            moneys2.push(d["money"]-600)
          }
          this.names = names;
          this.moneys = moneys;
          this.moneys2 = moneys2;
          this.drawLine();
        }).catch(error => {
          console.log(error)
        });
      },
      onSubmit(){
        this.getDepartmentNames();
      }
    }
  }
</script>

<style scoped>

</style>
