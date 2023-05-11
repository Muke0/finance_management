package com.l024.finance.service;

import com.l024.finance.entity.FmMoneyTypeEntity;
import com.l024.finance.repository.FmMoneyTypeRepository;
import com.l024.finance.util.LogUtil;
import com.l024.finance.util.StringUtil;
import com.l024.finance.vo.SpringBeanUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FmMoneyTypeService implements BaseService<FmMoneyTypeEntity> {
    @Autowired
    private FmMoneyTypeRepository fmMoneyTypeRepository;
    @Override
    public boolean add(FmMoneyTypeEntity fmMoneyTypeEntity) {
        if(fmMoneyTypeEntity!=null){

            FmMoneyTypeEntity save = fmMoneyTypeRepository.save(fmMoneyTypeEntity);
            if(save!=null){
                return true;
            }
        }
        return false;
    }

    @Override
    public boolean del(long id) {
        if(id>0){
            fmMoneyTypeRepository.deleteById(id);
        }
        return true;
    }

    @Override
    public List<FmMoneyTypeEntity> getAll() {
        return fmMoneyTypeRepository.findAll();
    }

    @Override
    public boolean update(FmMoneyTypeEntity fmMoneyTypeEntity) {
        if(fmMoneyTypeEntity!=null){
            FmMoneyTypeEntity dbFmMoneyType = fmMoneyTypeRepository.findById(fmMoneyTypeEntity.getId()).get();
            SpringBeanUtil.copyPropertiesIgnoreNull(fmMoneyTypeEntity,dbFmMoneyType);
            FmMoneyTypeEntity save = fmMoneyTypeRepository.save(dbFmMoneyType);
            if(save!=null){
                return true;
            }
        }
        return false;
    }

    public boolean isExistMoneyType(String name){
        if(!StringUtil.isEmpty(name)){
            FmMoneyTypeEntity fmMoneyTypeEntity = fmMoneyTypeRepository.findFmMoneyTypeEntityByName(name);
            LogUtil.i("查询到的支出类型：",fmMoneyTypeEntity);
            if(fmMoneyTypeEntity!=null){
                return true;
            }
        }
        return false;
    }
}
