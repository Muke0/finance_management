package com.l024.finance.controller;

import com.l024.finance.entity.FmMoneyTypeEntity;
import com.l024.finance.service.FmMoneyTypeService;
import com.l024.finance.util.StringUtil;
import com.l024.finance.util.UserLoginToken;
import com.l024.finance.vo.R;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Api(value="支出收入类型管理")
@RestController
@RequestMapping("/moneytype")
public class FmMoneyTypeController implements BaseController<FmMoneyTypeEntity> {
    @Autowired
    private FmMoneyTypeService fmMoneyTypeService;

    @ApiOperation(httpMethod = "POST", value = "添加收入支出标签类型", response = R.class,
            notes = "添加收入支出标签类型")
    @PostMapping("/add")
    @UserLoginToken
    @Override
    public R add(@RequestBody FmMoneyTypeEntity fmMoneyTypeEntity) {
        if(fmMoneyTypeEntity!=null&& !StringUtil.isEmpty(fmMoneyTypeEntity.getName())){
            //先判断是否存在
            boolean existMoneyType = fmMoneyTypeService.isExistMoneyType(fmMoneyTypeEntity.getName());
            if(!existMoneyType){
                boolean add = fmMoneyTypeService.add(fmMoneyTypeEntity);
                if(add){
                    return R.ok("添加成功","");
                }
            }else{
                return R.error(500,"添加失败,改类型已经存在");

            }
        }
        return R.error(500,"添加类型失败");
    }

    @ApiOperation(httpMethod = "GET", value = "删除收入支出标签类型", response = R.class,
            notes = "删除收入支出标签类型")
    @GetMapping("/del")
    @UserLoginToken
    @Override
    public R del(Long id) {
        if(id>0){
            fmMoneyTypeService.del(id);
            return R.ok("删除成功","");
        }
        return R.error(500,"删除失败");
    }

    @ApiOperation(httpMethod = "POST", value = "更新收入支出标签类型", response = R.class,
            notes = "更新收入支出标签类型")
    @PostMapping("/update")
    @UserLoginToken
    @Override
    public R update(@RequestBody FmMoneyTypeEntity fmMoneyTypeEntity) {
        if(fmMoneyTypeEntity!=null){
            boolean update = fmMoneyTypeService.update(fmMoneyTypeEntity);
            if(update){
                return R.ok("更新成功","");
            }
        }
        return R.error(500,"更新失败");
    }

    @ApiOperation(httpMethod = "GET", value = "获取所有收入支出标签类型", response = R.class,
            notes = "获取所有收入支出标签类型")
    @GetMapping("/all")
    @UserLoginToken
    @Override
    public R getAll() {
        //处理下收入和支出
        List<FmMoneyTypeEntity> all = fmMoneyTypeService.getAll();
        if(all!=null&&all.size()>0){
            Map<String,List<FmMoneyTypeEntity>> map = new HashMap<>();
            //收入
            List<FmMoneyTypeEntity> incomeList = new ArrayList<>();
            //支出
            List<FmMoneyTypeEntity> expenditureList = new ArrayList<>();
            for (FmMoneyTypeEntity fmMoneyTypeEntity : all) {
                if(fmMoneyTypeEntity.getType()==1){
                    expenditureList.add(fmMoneyTypeEntity);
                }else{
                    incomeList.add(fmMoneyTypeEntity);
                }
            }
            map.put("income",incomeList);
            map.put("expenditure",expenditureList);
            return R.ok("获取成功",map);
        }
        return R.ok("获取成功","");
    }

    @Override
    public R get(FmMoneyTypeEntity fmMoneyTypeEntity) {
        return null;
    }
}
