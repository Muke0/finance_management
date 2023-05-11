<template>
  <el-row style="margin: 20px;">
    <el-table
      :data="businessInfo.content"
      style="width: 100%;margin-top: 20px;">

      <el-table-column
        prop="name"
        label="业务名称">
      </el-table-column>

      <el-table-column
        prop="note"
        label="业务描述">
      </el-table-column>

      <el-table-column
        prop="money"
        label="业务奖金">
      </el-table-column>

      <el-table-column
        prop="startTime"
        label="业务开始时间">
      </el-table-column>
      <el-table-column
        prop="endTime"
        label="业务结束时间">
      </el-table-column>
      <el-table-column
        prop="state"
        label="业务状态">
        <template slot-scope="scope">
          <el-tag
            :type="scope.row.state === 1 ? 'primary' : 'success'"
            disable-transitions>{{scope.row.state===1?'待完成':'已完成'}}</el-tag>
        </template>

      </el-table-column>

      <el-table-column
        prop="department.name"
        label="业务部门">
      </el-table-column>

      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button
            size="mini"
            @click="editBusiness(scope.$index, scope.row)">立即完成</el-button>
        </template>
      </el-table-column>
    </el-table>
    <!--添加或者修改部门-->
  </el-row>
</template>

<script>
  import {getBusinessPages,updateBusiness,delBusiness} from '@/api/business'
  import {getUserInfo} from '@/api/user'

  import {getDepartmentNames} from '@/api/department';
  import {parseTime} from "@/utils";
  export default {
    name: 'User',
    data(){
      return{
        activeName:"account",
        formLabelWidth: "150px",
        businessInfo:{
          content:[],//数据
          currentPage:0,//当前页数
          totalElements:0,//总条数
          totalPage:0//总页数
        },
        //业务信息
        business:{
          id:null,
          name:"",
          note:"",
          money:null,
          startTime:"",
          endTime:"",
          department:{
            id:null,
            name:""
          }
        },
        showBusiness:false,
        isAddBusiness:true,
        businessTitle:"添加业务信息",
        pageSize:1000,
        departmentNames:[],
        userInfo:{}
      };
    },
    mounted(){
      this.getUserInfo();
    },
    methods:{
      getUserInfo(){
        getUserInfo().then(response => {
          const { data} = response
          this.userInfo = data;
          //在获取数据
          this.getBusinessPages(this.businessInfo.currentPage);
        }).catch(error => {
          this.$message({
            message: error,
            type: "error"
          });
        });
      },
      getBusinessPages(page){
        getBusinessPages(page,this.pageSize).then(response => {
          const { data} = response;
          let d = [];
          if (data&&data.content){
            for(let i=0;i<data.content.length;i++){
              let item = data.content[i];
              //只要自己的部门任务
              if(item["department"]["id"]===this.userInfo["department"]["id"]&&item["state"]===1){
                console.log(item["department"]["id"]+"---"+this.userInfo["department"]["id"])
                d.push(item);
              }
            }
            this.businessInfo.content = d;
          }
          console.log(data)
        }).catch(error => {
          console.log(error)
        });
      },
      //部门分页
      changeBusinessPage(page){
        console.log("切换页码"+page)
        this.getBusinessPages(page-1);
      },

      //更新部门信息
      editBusiness(index,row){
        console.log(row);
        this.business = row;
        this.business.state = 2;
        this.updateBusiness();
      },
      //修改部门信息
      updateBusiness(){
        updateBusiness(this.business).then(response => {
          this.$message({
            message: "任务完成",
            type: "success"
          });
          if (this.$refs["businessForm"] !== undefined) {
            this.$refs["businessForm"].resetFields();
          }
          this.showBusiness = false;
          this.getBusinessPages(this.businessInfo.currentPage);
        }).catch(error => {
          console.log(error)
        });
      },
      delBusiness(index,row){
        delBusiness(row.id).then(response => {
          this.$message({
            message: "删除成功",
            type: "success"
          });
          this.getBusinessPages(0);
        }).catch(error => {
          console.log(error)
        });
      },
      getDepartmentNames(){
        getDepartmentNames().then(response => {
          this.departmentNames = response.data;
        }).catch(error => {
          console.log(error)
        });
      }
    },
    filters:{
      formatDate:function(time) {
        if(time!=null&&time!=="")
        {
          // var date = new Date(time);
          return parseTime(time, '{y}-{m}-{d}');
        }else{
          return "";
        }
      }
    }
  }
</script>

<style scoped>

</style>
