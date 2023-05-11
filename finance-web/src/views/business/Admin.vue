<template>
  <el-row style="margin: 20px;">
    <el-button type="primary" style="margin: 5px;" @click="addBusinessClick">添加业务功能</el-button>
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
            @click="editBusiness(scope.$index, scope.row)">编辑</el-button>
          <el-button
            size="mini"
            type="danger"
            @click="delBusiness(scope.$index, scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      background
      layout="prev, pager, next"
      :page-size="10"
      :total="businessInfo.totalElements"
      :page-count="businessInfo.totalPage"
      @current-change="changeBusinessPage">
    </el-pagination>

    <!--添加或者修改部门-->
    <el-dialog :title="businessTitle" :visible.sync="showBusiness">
      <el-form :model="business" ref="businessForm">
        <el-form-item v-if="!isAddBusiness" label="id" :label-width="formLabelWidth">
          <el-input v-model="business.id" autocomplete="off" disabled></el-input>
        </el-form-item>
        <el-form-item label="业务名称" :label-width="formLabelWidth">
          <el-input v-model="business.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="业务描述" :label-width="formLabelWidth">
          <el-input v-model="business.note" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="业务奖金" :label-width="formLabelWidth">
          <el-input v-model="business.money" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="业务状态" prop="sex" :label-width="formLabelWidth">
          <el-col :span="8">
            <el-radio-group v-model="business.state">
              <el-radio-button label="1">待完成</el-radio-button>
              <el-radio-button label="2">已完成</el-radio-button>
            </el-radio-group>
          </el-col>
        </el-form-item>

        <el-form-item label="业务开始时间" required :label-width="formLabelWidth">
          <el-date-picker type="date" format="yyyy-MM-dd" value-format="yyyy-MM-dd" placeholder="选择日期" v-model="business.startTime" style="width: 100%;"></el-date-picker>
        </el-form-item>
        <el-form-item label="业务结束时间" required :label-width="formLabelWidth">
          <el-date-picker type="date" format="yyyy-MM-dd" value-format="yyyy-MM-dd" placeholder="选择日期" v-model="business.endTime" style="width: 100%;"></el-date-picker>
        </el-form-item>
        <el-form-item label="业务所属部门" :label-width="formLabelWidth">
          <el-select v-model="business.department.id" placeholder="业务所属部门">
            <el-option v-for="(item,index) in departmentNames" :key="index" :label="item.name" :value="item.id"></el-option>
          </el-select>
        </el-form-item>

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="showBusiness = false">取 消</el-button>
        <el-button v-if="isAddBusiness" type="primary" @click="addBusiness">添加</el-button>
        <el-button v-else type="primary" @click="updateBusiness">修改</el-button>
      </div>
    </el-dialog>
  </el-row>
</template>

<script>
  import {getBusinessPages,addBusiness,updateBusiness,delBusiness} from '@/api/business'
  import {getDepartmentNames} from '@/api/department';
  import {parseTime} from "@/utils";
  export default {
    name: 'Admin',
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
        pageSize:10,
        departmentNames:[]
      };
    },
    mounted(){
      this.getBusinessPages(this.businessInfo.currentPage);
      this.getDepartmentNames();
    },
    methods:{

      getBusinessPages(page){
        getBusinessPages(page,this.pageSize).then(response => {
          const { data} = response
          this.businessInfo = data;
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
      addBusinessClick(){
        this.showBusiness = true;
        this.businessTitle="添加业务信息";
        this.isAddBusiness = true;
        this.business={
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
        }
      },
      addBusiness(){
        addBusiness(this.business).then(response => {
          this.$message({
            message: "添加成功",
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
      //更新部门信息
      editBusiness(index,row){
        console.log(row);
        this.business = row;
        this.showBusiness = true;
        this.showBusiness = true;
        this.isAddBusiness = false
        this.businessTitle="修改信息";
      },
      //修改部门信息
      updateBusiness(){
        updateBusiness(this.business).then(response => {
          this.$message({
            message: "修改成功",
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
