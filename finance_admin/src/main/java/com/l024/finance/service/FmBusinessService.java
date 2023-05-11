package com.l024.finance.service;

import com.l024.finance.entity.FmBusinessEntity;
import com.l024.finance.entity.FmDepartmentEntity;
import com.l024.finance.entity.PageEntity;
import com.l024.finance.repository.FmBusinessRepository;
import com.l024.finance.repository.FmDepartmentRepository;
import com.l024.finance.util.LogUtil;
import com.l024.finance.vo.SpringBeanUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 业务管理
 */
@Service
public class FmBusinessService implements BaseService<FmBusinessEntity> {

    @Autowired
    private FmBusinessRepository fmBusinessRepository;
    @Autowired
    private FmDepartmentRepository fmDepartmentRepository;

    @Override
    public boolean add(FmBusinessEntity fmBusinessEntity) {

        FmBusinessEntity save = fmBusinessRepository.save(fmBusinessEntity);
        if(save!=null){
            return true;
        }
        return false;
    }

    @Override
    public boolean del(long id) {
        fmBusinessRepository.deleteById(id);
        return true;
    }

    @Override
    public List<FmBusinessEntity> getAll() {
        return null;
    }

    @Override
    public boolean update(FmBusinessEntity fmBusinessEntity) {
        //先查询
        FmBusinessEntity businessEntity = fmBusinessRepository.findById(fmBusinessEntity.getId()).get();
        if(businessEntity!=null){
            SpringBeanUtil.copyPropertiesIgnoreNull(fmBusinessEntity,businessEntity);
            fmBusinessRepository.save(businessEntity);
            LogUtil.i("更新业务信息：",businessEntity);
            //更新部门的工资
            FmDepartmentEntity department = businessEntity.getDepartment();
            if(department!=null&&department.getId()>0){
                department.setMoney(department.getMoney()+businessEntity.getMoney());
                fmDepartmentRepository.save(department);
            }
            return fmBusinessRepository.save(businessEntity) != null;
        }
        return false;
    }


    /**
     * 分页获取部门数据
     * @param page
     * @param size
     * @return
     */
    public PageEntity<FmBusinessEntity> getPages(int page, int size){
        if(page<0){
            page = 0;
        }
        if(size<0){
            size = 10;
        }
        PageRequest pageRequest =PageRequest.of(page,size);
        Page<FmBusinessEntity> fmBusinessEntityPage = fmBusinessRepository.findAll(pageRequest);
        if(fmBusinessEntityPage!=null){
            PageEntity<FmBusinessEntity> pages = new PageEntity<>();
            pages.setCurrentPage(fmBusinessEntityPage.getNumber());
            pages.setTotalElements(fmBusinessEntityPage.getTotalElements());
            pages.setTotalPage(fmBusinessEntityPage.getTotalPages());
            pages.setContent(fmBusinessEntityPage.getContent());
            return pages;
        }
        return null;
    }

}
