package com.l024.finance.controller;

import com.l024.finance.entity.FmBusinessEntity;
import com.l024.finance.entity.PageEntity;
import com.l024.finance.service.FmBusinessService;
import com.l024.finance.util.UserLoginToken;
import com.l024.finance.vo.R;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Api(value="工资表相关")
@RestController
@RequestMapping("/task")
public class TaskController implements BaseController<FmBusinessEntity>{
    @Autowired
    private FmBusinessService fmBusinessService;

    @ApiOperation(httpMethod = "POST", value = "添加业务", response = R.class,
            notes = "添加业务")
    @PostMapping("/add")
    @UserLoginToken
    @Override
    public R add(@RequestBody FmBusinessEntity fmBusinessEntity) {
        if(fmBusinessEntity!=null){
            boolean add = fmBusinessService.add(fmBusinessEntity);
            if(add){
                return R.ok("添加成功","");
            }
        }
        return R.error(500,"添加失败");
    }

    @ApiOperation(httpMethod = "POST", value = "删除业务", response = R.class,
            notes = "删除业务")
    @GetMapping("/del")
    @UserLoginToken
    @Override
    public R del(Long id) {
        if(id>0){
            boolean del = fmBusinessService.del(id);
            if(del){
                return R.ok("删除成功","");
            }
        }
        return R.error(500,"删除失败");
    }

    @ApiOperation(httpMethod = "POST", value = "更新业务信息", response = R.class,
            notes = "更新业务信息")
    @PostMapping("/update")
    @UserLoginToken
    @Override
    public R update(@RequestBody FmBusinessEntity fmBusinessEntity) {
        if(fmBusinessEntity!=null&&fmBusinessEntity.getId()>0){
            boolean update = fmBusinessService.update(fmBusinessEntity);
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
    public R get(FmBusinessEntity fmBusinessEntity) {
        return null;
    }

    @ApiOperation(httpMethod = "POST", value = "分页获取业务信息", response = R.class,
            notes = "分页获取业务信息")
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
            PageEntity<FmBusinessEntity> pages = fmBusinessService.getPages(page, size);
            return R.ok("获取收入支出列表",pages);
        }
        return R.ok("获取收入支出列表","");
    }
}
