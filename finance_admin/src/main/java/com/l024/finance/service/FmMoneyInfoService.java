package com.l024.finance.service;

import com.l024.finance.entity.FmMoneyInfoEntity;
import com.l024.finance.entity.PageEntity;
import com.l024.finance.entity.SysUserEntity;
import com.l024.finance.repository.FmMoneyInfoRepository;
import com.l024.finance.util.StringUtil;
import com.l024.finance.util.TokenUtil;
import com.l024.finance.vo.SpringBeanUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;

/**
 * 收入支出明细
 */
@Service
public class FmMoneyInfoService implements BaseService<FmMoneyInfoEntity>{
    @Autowired
    private FmMoneyInfoRepository fmMoneyInfoRepository;
    @Autowired
    private SysUserService sysUserService;

    @Override
    public boolean add(FmMoneyInfoEntity fmMoneyInfoEntity) {
        String tokenUserNumber = TokenUtil.getTokenUserNumber();
        if(!StringUtil.isEmpty(tokenUserNumber)&&fmMoneyInfoEntity!=null){
            //查询客户
            SysUserEntity user = sysUserService.findUserByNumber(tokenUserNumber);
            if(user!=null){
                fmMoneyInfoEntity.setUser(user);
//                FmMoneyTypeEntity moneyTypeEntity = new FmMoneyTypeEntity();
//                fmMoneyInfoEntity.setMoneyType(moneyTypeEntity);
//                fmMoneyInfoEntity.setUserId(user.getId());
                fmMoneyInfoEntity.setCreateTime(new Timestamp(System.currentTimeMillis()));

                FmMoneyInfoEntity save = fmMoneyInfoRepository.save(fmMoneyInfoEntity);
                if(save!=null){
                    return true;
                }
            }
        }
        return false;
    }

    @Override
    public boolean del(long id) {
        if(id>0){
            fmMoneyInfoRepository.deleteById(id);
            return  true;
        }
        return false;
    }

    @Override
    public List<FmMoneyInfoEntity> getAll() {
        return null;
    }

    @Override
    public boolean update(FmMoneyInfoEntity fmMoneyInfoEntity) {
        if(fmMoneyInfoEntity!=null&&fmMoneyInfoEntity.getId()>0){
            //根据id查询
            FmMoneyInfoEntity dbInfoEntity = fmMoneyInfoRepository.findById(fmMoneyInfoEntity.getId()).get();
            SpringBeanUtil.copyPropertiesIgnoreNull(fmMoneyInfoEntity,dbInfoEntity);
            FmMoneyInfoEntity save = fmMoneyInfoRepository.save(dbInfoEntity);
            if(save!=null){
                return true;
            }
        }
        return false;
    }

    /**
     * 分页获取
     * @param page
     * @param size
     * @return
     */
    public PageEntity<FmMoneyInfoEntity> getPage(int page,int size){
        if(page<0){
            page = 0;
        }
        if(size<0){
            size = 10;
        }
        PageRequest pageRequest =PageRequest.of(page,size);
        Page<FmMoneyInfoEntity> fmCompanyEntityPage = fmMoneyInfoRepository.findAll(pageRequest);
        if(fmCompanyEntityPage!=null){
            PageEntity<FmMoneyInfoEntity> pages = new PageEntity<>();
            pages.setCurrentPage(fmCompanyEntityPage.getNumber());
            pages.setTotalElements(fmCompanyEntityPage.getTotalElements());
            pages.setTotalPage(fmCompanyEntityPage.getTotalPages());
            pages.setContent(fmCompanyEntityPage.getContent());
            return pages;
        }
        return null;
    }
}
