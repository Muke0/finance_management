package com.l024.finance.repository;

import com.l024.finance.entity.SysUserEntity;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * 系统用户操作
 */
public interface SysUserRepository extends PagingAndSortingRepository<SysUserEntity,Long> {
    //根据编号来查询
    SysUserEntity querySysUserEntitiesByNumber(String number);
    SysUserEntity querySysUserEntitiesByPhone(String phone);
}
