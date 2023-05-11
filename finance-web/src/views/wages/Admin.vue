<template>
  <el-row style="margin: 20px;">
    <el-button type="primary" style="margin: 5px;" @click="addDepartmentClick">添加部门</el-button>
    <el-table
      :data="departmentInfo.content"
      style="width: 100%;margin-top: 20px;">

      <el-table-column
        prop="name"
        label="部门名称">
      </el-table-column>

      <el-table-column
        prop="money"
        label="部门工资">
      </el-table-column>

      <el-table-column
        prop="businessAmount"
        label="部门业务金额">
      </el-table-column>

      <el-table-column
        prop="note"
        label="部门描述">
      </el-table-column>

      <el-table-column
        label="创建时间"
        prop="createTime">
        <template slot-scope="scope">
          <i class="el-icon-time"></i>
          <span style="margin-left: 10px">{{ scope.row.createTime|formatDate}}</span>
        </template>
      </el-table-column>

      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button
            size="mini"
            @click="editDepartment(scope.$index, scope.row)">编辑</el-button>
          <el-button
            size="mini"
            type="danger"
            @click="delDepartment(scope.$index, scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      background
      layout="prev, pager, next"
      :page-size="10"
      :total="departmentInfo.totalElements"
      :page-count="departmentInfo.totalPage"
      @current-change="changeDepartmentPage">
    </el-pagination>

    <!--添加或者修改部门-->
    <el-dialog :title="departmentTitle" :visible.sync="showDepartment">
      <el-form :model="department">
        <el-form-item v-if="!isAddDepartment" label="id" :label-width="formLabelWidth">
          <el-input v-model="department.id" autocomplete="off" disabled></el-input>
        </el-form-item>
        <el-form-item label="部门名称" :label-width="formLabelWidth">
          <el-input v-model="department.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="部门工资" :label-width="formLabelWidth">
          <el-input v-model="department.money" autocomplete="off"></el-input>
        </el-form-item>

        <el-form-item label="部门业务工资" :label-width="formLabelWidth">
          <el-input v-model="department.businessAmount" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="部门备注" :label-width="formLabelWidth">
          <el-input v-model="department.note" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="showDepartment = false">取 消</el-button>
        <el-button v-if="isAddDepartment" type="primary" @click="addDepartment">添加</el-button>
        <el-button v-else type="primary" @click="updateDepartment">修改</el-button>
      </div>
    </el-dialog>
  </el-row>
</template>

<script>
  import {getDepartmentPages,addDepartment,updateDepartment,delDepartment} from '@/api/department'
  import {parseTime} from "@/utils";
  export default {
    name: 'Admin',
    data(){
      return{
        activeName:"account",
        formLabelWidth: "150px",
        info:{},//公司信息
        departmentInfo:{
          content:[],//数据
          currentPage:0,//当前页数
          totalElements:0,//总条数
          totalPage:0//总页数
        },
        //部门信息
        department:{
          id:0,
          name:"",
          note:"",
          money:null,
          businessAmount:null
        },
        showDepartment:false,
        isAddDepartment:true,
        departmentTitle:"添加部门信息",
        pageSize:10,
      };
    },
    mounted(){
      this.getDepartmentPages(this.departmentInfo.currentPage);
    },
    methods:{

      getDepartmentPages(page){
        getDepartmentPages(page,this.pageSize).then(response => {
          const { data} = response
          this.departmentInfo = data;
          console.log(data)
        }).catch(error => {
          console.log(error)
        });
      },
      //部门分页
      changeDepartmentPage(page){
        console.log("切换页码"+page)
        this.getDepartmentPages(page-1);
      },
      addDepartmentClick(){
        this.showDepartment = true;
        this.departmentTitle="添加部门信息";
        this.isAddDepartment = true;
        this.department={
          id:0,
            name:"",
            note:"",
            money:null,
            businessAmount:null
        }
      },
      //添加部门信息
      addDepartment(){
        this.showDepartment = false;
        addDepartment(this.department).then(response => {
          this.$message({
            message: "添加部门成功",
            type: "success"
          });
          this.department = {};
          this.getDepartmentPages(this.departmentInfo.currentPage);
        }).catch(error => {
          console.log(error)
        });
      },
      //更新部门信息
      editDepartment(index,row){
        console.log(row);
        this.department = row;
        this.showDepartment = true;
        this.showDepartment = true;
        this.isAddDepartment = false
        this.departmentTitle="修改部门信息";
      },
      //修改部门信息
      updateDepartment(){
        this.showDepartment = false;
        updateDepartment(this.department).then(response => {
          this.$message({
            message: "修改部门成功",
            type: "success"
          });
          this.department = {};
          this.getDepartmentPages(this.departmentInfo.currentPage);
        }).catch(error => {
          console.log(error)
        });
      },
      delDepartment(index,row){
        delDepartment(row.id).then(response => {
          this.$message({
            message: "删除部门成功",
            type: "success"
          });
          this.department = {};
          this.getDepartmentPages(0);
        }).catch(error => {
          console.log(error)
        });
      },
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
