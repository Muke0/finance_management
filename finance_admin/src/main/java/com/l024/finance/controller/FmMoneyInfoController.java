package com.l024.finance.controller;

import com.l024.finance.entity.FmMoneyInfoEntity;
import com.l024.finance.entity.PageEntity;
import com.l024.finance.service.FmMoneyInfoService;
import com.l024.finance.util.UserLoginToken;
import com.l024.finance.vo.R;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Api(value="支出收入管理")
@RestController
@RequestMapping("/moneyinfo")
public class FmMoneyInfoController implements BaseController<FmMoneyInfoEntity> {
   @Autowired
   private FmMoneyInfoService fmMoneyInfoService;

    @ApiOperation(httpMethod = "POST", value = "添加支出收入", response = R.class,
            notes = "添加支出收入")
    @PostMapping("/add")
    @UserLoginToken
    @Override
    public R add(@RequestBody FmMoneyInfoEntity fmMoneyInfoEntity) {
        if(fmMoneyInfoEntity!=null){
            boolean add = fmMoneyInfoService.add(fmMoneyInfoEntity);
            if(add){
                return R.ok("添加成功","");
            }
        }
        return R.error(500,"添加失败");
    }

    @ApiOperation(httpMethod = "GET", value = "删除收入支出", response = R.class,
            notes = "删除收入支出")
    @GetMapping("/del")
    @UserLoginToken
    @Override
    public R del(Long id) {
        if(id>0){
            boolean del = fmMoneyInfoService.del(id);
            if(del){
                return R.ok("删除成功","");
            }
        }
        return R.error(500,"删除失败");
    }

    @ApiOperation(httpMethod = "POST", value = "更新收入支出信息", response = R.class,
            notes = "更新收入支出信息")
    @PostMapping("/update")
    @UserLoginToken
    @Override
    public R update(FmMoneyInfoEntity fmMoneyInfoEntity) {
        if(fmMoneyInfoEntity!=null&&fmMoneyInfoEntity.getId()>0){
            boolean update = fmMoneyInfoService.update(fmMoneyInfoEntity);
            if(update){
                return R.ok("更新成功","");
            }
        }
        return R.error(500,"更新失败");
    }

    @Override
    public R getAll() {
        return null;
    }

    @Override
    public R get(FmMoneyInfoEntity fmMoneyInfoEntity) {
        return null;
    }

    @ApiOperation(httpMethod = "POST", value = "分页获取收入支出信息", response = R.class,
            notes = "分页获取收入支出信息")
    @PostMapping("/page")
    @UserLoginToken
    public R getPages(@RequestBody Map<String,Object> map) {
        if(map!=null){
            int page = 0;
            int size = 10;
            if(map.containsKey("page")){
                page = (int)map.get("page");
            }
            if(map.containsKey("size")){
                size = (int)map.get("size");
            }
            PageEntity<FmMoneyInfoEntity> pages = fmMoneyInfoService.getPage(page, size);
            return R.ok("获取收入支出列表",pages);
        }
        return R.ok("获取收入支出列表","");
    }
}
