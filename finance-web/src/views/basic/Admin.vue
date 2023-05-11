<template>
  <div class="all-container" style="margin-left: 20px;">
    <div class="all-container-padding bg" >
      <el-tabs v-model="activeName">
        <el-tab-pane label="公司信息" name="account">
          <el-row>
            <el-col :span="24">
              <el-card class="box-card">
                <el-col :span="6">
                  <el-image
                    :src="info.icon"
                    fit="fill"
                    style="margin-left: 10px;">

                  </el-image>
                </el-col>
                <el-col :span="18">
                  <el-col :span="24" style="margin-top: 20px;"><label>公司名:{{info.name}}</label></el-col>
                  <el-col :span="24" style="margin-top: 20px;"><label>公司地址:{{info.address}}</label></el-col>
                  <el-col :span="24" style="margin-top: 20px;"><label>公司人数:{{info.count}}</label></el-col>
                  <el-col :span="24" style="margin-top: 20px;"><label>公司资金余额:{{info.money}}</label></el-col>
                  <el-col :span="24" style="margin-top: 20px;"><label>公司创建时间:{{info.createTime|formatDate}}</label></el-col>
                  <el-col :span="24" style="margin-top: 20px;"><label>公司介绍:XX是拥有强大互联网基础的领先AI公司。XX愿景是：成为最懂用户，并能帮助人们成长的全球顶级高科技公司</label></el-col>

                </el-col>
              </el-card>
            </el-col>
           </el-row>
        </el-tab-pane>
        <el-tab-pane label="部门信息" name="department">
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
        </el-tab-pane>
        <el-tab-pane label="业务支出/收入类别" name="business">
          <el-row>
            <el-col :span="10" :offset="1">
              <el-card class="box-card">
                <div slot="header" class="clearfix">
                  <span>支出类型</span>
                  <el-button style="float: right; padding: 3px 0" type="text" @click="showAddMoneyType(1)">添加支出类型</el-button>
                </div>
                <el-row v-for="item in moneyTypes.expenditure" :key="item.id" class="text item">
                  <el-col :span="18">
                    <el-tag>{{item.name}}</el-tag>
                  </el-col>
                  <el-col :span="6">
                    <el-button type="primary" icon="el-icon-edit" circle @click="showUpdateMoneyType"></el-button>
                    <el-button type="danger" icon="el-icon-delete" circle @click="delMoneyType(item.id)"></el-button>
                  </el-col>
                </el-row>
              </el-card>
            </el-col>
            <el-col :span="10" :offset="1">
              <el-card class="box-card">
                <div slot="header" class="clearfix">
                  <span>收入类型</span>
                  <el-button style="float: right; padding: 3px 0" type="text" @click="showAddMoneyType(2)">添加收入类型</el-button>
                </div>
                <el-row v-for="item in moneyTypes.income" :key="item.id" class="text item">
                  <el-col :span="18">
                    <el-tag>{{item.name}}</el-tag>
                  </el-col>
                  <el-col :span="6">
                    <el-button type="primary" icon="el-icon-edit" circle @click="showUpdateMoneyType"></el-button>
                    <el-button type="danger" icon="el-icon-delete" circle @click="delMoneyType(item.id)"></el-button>
                  </el-col>
                </el-row>
              </el-card>
            </el-col>

          </el-row>
        </el-tab-pane>
        <el-tab-pane label="支出项目" name="expenditure">
          <el-table
            :data="moneyInfo.content"
            style="width: 100%;margin-top: 20px;">

            <el-table-column
              label="序号"
              type="index">
            </el-table-column>
            <el-table-column
              prop="name"
              label="支出项名称">
            </el-table-column>

            <el-table-column
              prop="money"
              label="支出项金额">
            </el-table-column>

            <el-table-column
              prop="note"
              label="支出项描述">
            </el-table-column>

            <el-table-column
              prop="user.name"
              label="支出项用户">
            </el-table-column>

            <el-table-column
              prop="moneyType.name"
              label="支出项类型">
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
                  @click="exportMoneyInfo(scope.$index, scope.row)">导出</el-button>
              </template>
            </el-table-column>
          </el-table>
          <el-pagination
            background
            layout="prev, pager, next"
            :page-size="10"
            :total="moneyInfo.totalElements"
            :page-count="moneyInfo.totalPage"
            @current-change="changeMoneyInfoPage">
          </el-pagination>
        </el-tab-pane>
      </el-tabs>
    </div>
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
    <!--添加或者修改收入或者支出标签-->
    <el-dialog :title="moneyTypeTitle" :visible.sync="showMoneyType">
      <el-form :model="moneyType">
        <el-form-item label="类型名称" :label-width="formLabelWidth">
          <el-input v-model="moneyType.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="类型" :label-width="formLabelWidth">
          <el-select v-model="moneyType.type" placeholder="请选择类型">
            <el-option label="支出类型" value="1"></el-option>
            <el-option label="收入类型" value="2"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="showMoneyType = false">取 消</el-button>
        <el-button v-if="isAddMoneyType" type="primary" @click="addMoneyType">添加</el-button>
        <el-button v-else type="primary" @click="updateMoneyType">修改</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
  import {getInfo} from '@/api/company'
  import {getMoneyInfoPages} from '@/api/moneyinfo'
  import {getMoneyTypes,addMoneyTypes,updateMoneyTypes,delMoneyTypes} from '@/api/moneytype'
  import {getDepartmentPages,addDepartment,updateDepartment,delDepartment} from '@/api/department'
  import {parseTime} from "@/utils"
  import "@/excel/Blob";
  import "@/excel/export2Excel";
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
        moneyInfo:{
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
        //收入支出类别
        moneyTypes:{
          "income":[],
          "expenditure":[],
        },
        moneyTypeTitle:"添加类型",
        showMoneyType:false,
        isAddMoneyType:true,
        moneyType:{
          name:"",
          type:null
        }
      };
    },
    mounted(){
      this.getInfo();
      this.getDepartmentPages(this.departmentInfo.currentPage);
      this.getMoneyTypes();
      this.getMoneyInfoPages();
    },
    methods:{
      getInfo(){
        getInfo().then(response => {
          const { data} = response
          this.info = data;
        }).catch(error => {
          console.log(error)
        });
      },
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
      //获取所有的收入支出类型
      getMoneyTypes(){
        getMoneyTypes().then(response => {
          const { data} = response
          this.moneyTypes = data;
        }).catch(error => {
          console.log(error)
        });
      },
      //添加收入支出类型
      showAddMoneyType(type){
        this.isAddMoneyType = true;
        if(type===1){
          this.moneyTypeTitle = "添加支出类型";
          this.moneyType.type = "1";
        }else{
          this.moneyTypeTitle = "添加收入类型";
          this.moneyType.type = "2";
        }

        this.showMoneyType = true;
      },
      showUpdateMoneyType(){
        this.isAddMoneyType = false;
        this.moneyTypeTitle = "修改类型";
        this.showMoneyType = true;
      },
      //添加支出类型
      addMoneyType(){
        addMoneyTypes(this.moneyType).then(response => {
          //更新
          this.$message({
            message: "添加类型成功",
            type: "success"
          });
          this.moneyType = {};
          this.getMoneyTypes()
          this.showMoneyType = false;
        }).catch(error => {
          console.log(error)
        });
      },
      //更新支出类型
      updateMoneyType(){
        updateMoneyTypes(this.moneyType).then(response => {
          //更新
          //更新
          this.$message({
            message: "更新类型成功",
            type: "success"
          });
          this.moneyType = {};
          this.getMoneyTypes()
          this.showMoneyType = false;
        }).catch(error => {
          console.log(error)
        });
      },
      //删除支出类型
      delMoneyType(id){
        delMoneyTypes(id).then(response => {
          //更新
          //更新
          this.$message({
            message: "删除类型成功",
            type: "success"
          });
          this.getMoneyTypes()
        }).catch(error => {
          console.log(error)
        });
      },
      getMoneyInfoPages(page){
        getMoneyInfoPages(page,this.pageSize).then(response => {
          const { data} = response;
          this.moneyInfo = data;
          if(data&&data.content){
            let d  = [];
            for(let i=0;i<data.content.length;i++){
              if(data.content[i].moneyType.type===1){
                d.push(data.content[i]);
              }
            }
            this.moneyInfo.content = d;
          }

          console.log(data)
        }).catch(error => {
          console.log(error)
        });
      },
      changeMoneyInfoPage(page){
        console.log("切换页码"+page)
        this.getMoneyInfoPages(page-1);
      },
      exportMoneyInfo(index,row){
        console.log(row)
        row["userName"] = row.user.name;
        row["moneyTypeName"] = row.moneyType.name;
        let d = [];
        d.push(row);
        this.export2Excel(d);

      },
      //数据写入excel
      export2Excel(d) {
        var that = this;
        require.ensure([], () => {
          const { export_json_to_excel } = require('@/excel/export2Excel'); //这里必须使用绝对路径，使用@/+存放export2Excel的路径
          const tHeader = ['支出项名称','支出项金额','支出项描述','支出项用户','支出项类型','支出项时间']; // 导出的表头名信息
          const filterVal = ['name','money', 'note', 'userName','moneyTypeName','createTime']; // 导出的表头字段名，需要导出表格字段名
          const data = that.formatJson(filterVal, d);
          export_json_to_excel(tHeader, data, '下载数据excel');// 导出的表格名称，根据需要自己命名
        })
      },
      //格式转换，直接复制即可
      formatJson(filterVal, jsonData) {
        return jsonData.map(v => filterVal.map(j => v[j]))
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
  .text {
    font-size: 14px;
  }

  .item {
    margin-bottom: 18px;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
  }

  .clearfix:before,
  .clearfix:after {
    display: table;
    content: "";
  }
  .clearfix:after {
    clear: both
  }

  .box-card {
    padding: 20px;
  }


</style>
