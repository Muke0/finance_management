<template>
  <headbar></headbar>
  <div class="card">
    <!-- 人员查询 -->
    <el-form :inline="true" :model="form">
      <el-form-item label="职工ID">
        <el-input v-model="form.user" placeholder="ID" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onQuery">Query</el-button>
      </el-form-item>
    </el-form>
    <el-row>
      <el-col :span="6">
        <el-statistic title="职工ID" :value="data.sId" />
      </el-col>
      <el-col :span="6">
        <el-statistic title="姓名" :value="data.sName" />
      </el-col>
      <el-col :span="6">
        <el-statistic title="职称" :value="data.sPosition" />
      </el-col>
      <el-col :span="6">
        <el-statistic title="类别" :value="data.sType" />
      </el-col>
    </el-row>
  </div>
  <div class="card">
    <div class="title">
      人员列表
      <el-button @click="dialogFormVisible = true" type="primary"> add </el-button>
    </div>

    <el-dialog v-model="dialogFormVisible" title="添加员工">
      <el-form :model="addform">
        <el-form-item label="教职工ID" :label-width="formLabelWidth">
          <el-input v-model="addform.sId" autocomplete="off" />
        </el-form-item>
        <el-form-item label="姓名" :label-width="formLabelWidth">
          <el-input v-model="addform.sName" autocomplete="off" />
        </el-form-item>
        <el-form-item label="职称" :label-width="formLabelWidth">
          <el-input v-model="addform.sPosition" autocomplete="off" />
        </el-form-item>
        <el-form-item label="类别" :label-width="formLabelWidth">
          <el-input v-model="addform.sType" autocomplete="off" />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogFormVisible = false">取消</el-button>
          <el-button type="primary" @click="onadd"> 确认 </el-button>
        </span>
      </template>
    </el-dialog>
    <el-dialog v-model="modifyDialogFormVisible" title="修改员工信息">
            <el-form :model="modifyform">
              <el-form-item label="教职工ID" :label-width="formLabelWidth">
                <el-input v-model="modifyform.sId" autocomplete="off" />
              </el-form-item>
              <el-form-item label="姓名" :label-width="formLabelWidth">
                <el-input v-model="modifyform.sName" autocomplete="off" />
              </el-form-item>
              <el-form-item label="职称" :label-width="formLabelWidth">
                <!-- <el-input v-model="modifyform.sPosition" autocomplete="off" /> -->
                     <el-select v-model="modifyform.sPosition" :placeholder="positionholder" >
                        <el-option v-for="item in positionOptions" :key="item.value" :lable="item.label" :value="item.value"></el-option>
                    </el-select>
              </el-form-item>
              <el-form-item label="类别" :label-width="formLabelWidth">
                <!-- <el-input v-model="modifyform.sType" autocomplete="off" /> -->
                     <el-select v-model="modifyform.sType" :placeholder="typeholder">
                      <el-option v-if="modifyform.sPosition=='教师'" v-for="item in typeOptions1" :key="item.value" :lable="item.label" :value="item.value"></el-option>
                      <el-option v-if="modifyform.sPosition=='职工'" v-for="item in typeOptions2" :key="item.value" :lable="item.label" :value="item.value"></el-option>
                    </el-select>
              </el-form-item>
            </el-form>
            <template #footer>
              <span class="dialog-footer">
                <el-button @click="modifyDialogFormVisible = false">取消</el-button>
                <el-button type="primary" @click="onmodify"> 确认 </el-button>
              </span>
            </template>
          </el-dialog>
    <el-table :data="tableData" stripe style="width: 100%">
      <el-table-column prop="sId" label="教职工ID" width="180" />
      <el-table-column prop="sName" label="姓名" width="180" />
      <el-table-column prop="sPosition" label="职称" />
      <el-table-column prop="sType" label="类别" />

      <el-table-column fixed="right" label="操作" width="160">
        <template #default="scope">
          <el-button
            link
            type="primary"
            @click="modifyClick(scope.$index, scope.row)"
            >修改</el-button
          >
          <el-button
            link
            type="primary"
            @click="deleteClick(scope.$index, scope.row)"
          >
            <el-icon>
              <Delete />
            </el-icon>
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <div style="text-align: center">
      <el-pagination
        layout="prev, pager, next"
        :total="10"
        style="margin: 0 auto; width: 200px"
      />
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "review",
  data() {
    return {
      form: {
        user: "",
      },
      addform: {
        sId: "",
        sName: "",
        sPosition: "",
        sType: "",
      },
      modifyform: {
        sId: "",
        sName: "",
        sPosition: "",
        sType: "",
      },
      data: {
        sId: "N/A",
        sName: "N/A",
        sPosition: "N/A",
        sType: "N/A",
      },
      positionOptions:[
        {
          value:"教师",
          label:"教师",
        },
        {
          value:"职工",
          label:"职工",
        }
      ],
      typeOptions1:[
        {
          value:"助教",
          label:"助教",
        },
        {
          value:"讲师",
          label:"讲师",
        },
        {
          value:"教授",
          label:"教授",
        },
        {
          value:"副教授",
          label:"副教授",
        },
      ],
      typeOptions2:[
        {
          value:"保卫科工作人员",
          label:"保卫科工作人员",
        },
        {
          value:"食堂工作人员",
          label:"食堂工作人员",
        },
        {
          value:"寝室楼工作人员",
          label:"寝室楼工作人员",
        },
      ],
      tableData: [],
      dialogFormVisible: false,
      modifyDialogFormVisible: false,
      formLabelWidth: "140px",
    };
  },
  mounted() {
    var config = {
      method: "get",
      url: "http://43.142.182.70:9998/staff/",
      headers: {
        Authorization: localStorage.getItem("token"),
      },
    };
    const _this = this;
    axios(config)
      .then(function (response) {
        console.log(response.data);
        response.data.forEach((data) => {
          _this.tableData.push(data);
        });
      })
      .catch(function (error) {
        console.log(error);
      });
  },
  methods: {
    onQuery() {
      this.tableData.forEach((e) => {
        if (e.sId == this.form.user) {
          this.data = e;
        }
      });
    },
    onadd() {
      this.dialogFormVisible = false;
      console.log(this.addform);
      var data = {
        sId: String(this.addform.sId),
        sName: this.addform.sName,
        sPosition: this.addform.sPosition,
        sType: this.addform.sType,
      };
      var config = {
        method: "post",
        url: "http://43.142.182.70:9998/staff/",
        headers: {
          Authorization: localStorage.getItem("token"),
        },
        data: data,
      };
      const _this = this;
      axios(config)
        .then(function (response) {
          console.log(response.data);
          var config = {
            method: "get",
            url: "http://43.142.182.70:9998/staff/",
            headers: {
              Authorization: localStorage.getItem("token"),
            },
          };

          axios(config)
            .then(function (response) {
              console.log(response.data);
              _this.tableData = [];
              response.data.forEach((data) => {
                _this.tableData.push(data);
              });
            })
            .catch(function (error) {
              console.log(error);
            });
        })
        .catch(function (error) {
          console.log(error);
        });
      var clearform = {
        sId: "",
        sName: "",
        sPosition: "",
        sType: "",
      };
      this.addform = clearform;
    },
    onmodify() {
      this.modifyDialogFormVisible = false;
      console.log(this.modifyform);
      var data = {
        sId: String(this.modifyform.sId),
        sName: this.modifyform.sName,
        sPosition: this.modifyform.sPosition,
        sType: this.modifyform.sType,
      };
      var config = {
        method: "put",
        url: "http://43.142.182.70:9998/staff/",
        headers: {
          Authorization: localStorage.getItem("token"),
        },
        data: data,
      };
      const _this = this;
      axios(config)
        .then(function (response) {
          console.log(response.data);
          var config = {
            method: "get",
            url: "http://43.142.182.70:9998/staff/",
            headers: {
              Authorization: localStorage.getItem("token"),
            },
          };

          axios(config)
            .then(function (response) {
              console.log(response.data);
              _this.tableData = [];
              response.data.forEach((data) => {
                _this.tableData.push(data);
              });
            })
            .catch(function (error) {
              console.log(error);
            });
        })
        .catch(function (error) {
          console.log(error);
        });
      var clearform = {
        sId: "",
        sName: "",
        sPosition: "",
        sType: "",
      };
      this.modifyform = clearform;
    },
    deleteClick(index, row) {
      // 发送审核删除请求
      console.log(index, row);
      const _this = this;

      var data = {
        sId: String(row.sId),
      };

      var config = {
        method: "delete",
        url: "http://43.142.182.70:9998/staff/",
        headers: {
          Authorization: localStorage.getItem("token"),
        },
        data: data,
      };

      axios(config)
        .then(function (response) {
          var config = {
            method: "get",
            url: "http://43.142.182.70:9998/staff/",
            headers: {
              Authorization: localStorage.getItem("token"),
            },
          };

          axios(config)
            .then(function (response) {
              console.log(response.data);
              _this.tableData = [];
              response.data.forEach((data) => {
                _this.tableData.push(data);
              });
            })
            .catch(function (error) {
              console.log(error);
            });
        })
        .catch(function (error) {
          console.log(error);
        });
    },
    modifyClick(index, row) {
      this.modifyform.sId = String(row.sId);
      this.modifyform.sName = row.sName;
      this.modifyform.sPosition = row.sPosition;
      this.modifyform.sType = row.sType;
      this.modifyDialogFormVisible = true;
    },
    positionholder(){
      return this.modifyform.sPosition;
    },
    typeholder(){
      return this.modifyform.sType;
    }
  },
};
</script>
