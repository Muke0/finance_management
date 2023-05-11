<template>
  <div class="all-container" style="margin-left: 20px;">
    <div class="all-container-padding bg" >
      <el-tabs v-model="activeName">
        <el-tab-pane label="基本信息" name="first">
          <el-form :model="userInfo" :rules="rules" ref="EditorUserForms">
            <el-form-item label="编号" prop="number" :label-width="formLabelWidth">
              <el-col :span="8"> <el-input v-model="userInfo.number" disabled ></el-input></el-col>
            </el-form-item>
            <el-form-item label="用户名" prop="name" :label-width="formLabelWidth">
              <el-col :span="8"> <el-input v-model="userInfo.name" disabled ></el-input></el-col>
            </el-form-item>
            <el-form-item label="手机号码" prop="phone" :label-width="formLabelWidth">
              <el-col :span="8">  <el-input v-model="userInfo.phone" placeholder="请输入电话"></el-input></el-col>
            </el-form-item>
            <el-form-item label="邮箱" prop="email" :label-width="formLabelWidth">
              <el-col :span="8">  <el-input v-model="userInfo.email" placeholder="请输入邮箱"></el-input></el-col>
            </el-form-item>
            <el-form-item label="地址" prop="address" :label-width="formLabelWidth">
              <el-col :span="8">  <el-input v-model="userInfo.address" placeholder="请输入地址"></el-input></el-col>
            </el-form-item>
            <el-form-item label="银行卡号" prop="bankNumber" :label-width="formLabelWidth">
              <el-col :span="8">  <el-input v-model="userInfo.bankNumber" placeholder="请输入银行卡号码"></el-input></el-col>
            </el-form-item>
            <el-form-item label="性别" prop="sex" :label-width="formLabelWidth">
              <el-col :span="8">
                <el-radio-group v-model="userInfo.sex">
                  <el-radio-button label="1">男</el-radio-button>
                  <el-radio-button label="2">女</el-radio-button>
                </el-radio-group>
              </el-col>
            </el-form-item>
            <el-form-item label="用户角色" prop="role" :label-width="formLabelWidth">
              <el-col :span="8">
                <el-input v-model="userInfo.role===1?'管理员':'用户'" disabled ></el-input>
              </el-col>
            </el-form-item>
          </el-form>
          <el-row>
            <el-col :span="6" :offset="5">
              <el-button type="primary" @click="editorUserClick('userInfo')" >提交修改</el-button>
            </el-col>
          </el-row>
        </el-tab-pane>
        <el-tab-pane label="修改密码" name="second">
          <el-form :model="ruleForm" :rules="rules" ref="updatePassword">
            <el-form-item label="原密码" prop="pass" :label-width="formLabelWidth">
              <el-col :span="8">  <el-input v-model="ruleForm.pass" placeholder="请输入原密码" type="password"></el-input></el-col>
            </el-form-item>
            <el-form-item label="新密码" prop="newpass" :label-width="formLabelWidth">
              <el-col :span="8"><el-input v-model="ruleForm.newpass" placeholder="请输入新密码" id="newkey" type="password"></el-input></el-col>
            </el-form-item>
            <el-form-item label="重复新密码" prop="checknewpass" :label-width="formLabelWidth">
              <el-col :span="8">  <el-input v-model="ruleForm.checknewpass" placeholder="请再次输入新密码" id='newkey1' type="password"></el-input></el-col>
            </el-form-item>
          </el-form>
          <el-row>
            <el-col :span="6" :offset="5">
              <el-button type="primary" @click="updatePassword()">修改密码</el-button>
            </el-col>
          </el-row>
        </el-tab-pane>
      </el-tabs>
    </div>
  </div>
</template>

<script>
  import {getUserInfo,updatePassword,updateUser} from '@/api/user'
  export default {
    name: 'User',
    data(){
      /*****检验两次密码是否一致***/
      var validatePass = (rule, value, callback) => {
        if (value === "") {
          callback(new Error("请输入密码"));
        } else {
          if (this.ruleForm.checknewpass !== "") {
            this.$refs.updatePassword.validateField("checknewpass");
          }
          callback();
        }
      };
      var validatePass2 = (rule, value, callback) => {
        if (value === "") {
          callback(new Error("请再次输入密码"));
        } else if (value !== this.ruleForm.newpass) {
          callback(new Error("两次输入密码不一致!"));
        } else {
          callback();
        }
      };
      return{
        ruleForm: {},//修改密码的表单
        activeName: "first",
        userInfo: {},//用户信息表单
        formLabelWidth: "150px",
        /***校验***/
        rules: {
          phone: [
            {
              required: true,
              message: "请输入手机号码"
            },
            {
              pattern: /^(1[0-9][0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/,
              message: "手机格式不对"
            }
          ],
          email: [
            {
              required: true,
              message: "请输入电子邮箱"
            },
            {
              pattern: /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/,
              message: "请输入有效的邮箱"
            }
          ],
          pass: [
            {
              required: true,
              trigger: "blur",
              message: "请输入密码"
            }
          ],
          newpass: [
            {
              validator: validatePass,
              trigger: "blur"
            },
            {
              required: true,
              message: "请输入新密码"
            }
          ],
          checknewpass: [
            {
              validator: validatePass2,
              trigger: "blur",
            },
            {
              required: true,
              message: "请再次输入新密码"
            }
          ]
        }
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
        }).catch(error => {
          this.$message({
            message: error,
            type: "error"
          });
        });
      },
      // 编辑提交的方法
      editorUserClick() {
        this.$refs.EditorUserForms.validate(valid => {
          if (valid) {
            console.log(this.userInfo);
            updateUser(JSON.stringify(this.userInfo)).then(response => {
              this.$message({
                message: "更新信息成功",
                type: "success"
              });
            }).catch(error => {
              console.log(error)
            });
          }
        });
      },
      //修改密码
      updatePassword() {
        this.$refs.updatePassword.validate(valid => {
          if (valid) {
            var data = {
              number: this.userInfo.number,
              oldpwd: this.ruleForm.pass,
              newpwd: this.ruleForm.newpass
            };
            console.log(data);
            updatePassword(JSON.stringify(data)).then(response => {
              this.$message({
                message: "更新密码成功",
                type: "success"
              });
            }).catch(error => {
              console.log(error)
            });
          }
        });
      },
    }
  }
</script>

<style scoped>

</style>
