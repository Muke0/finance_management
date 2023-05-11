package com.l024.finance.repository;

import com.l024.finance.entity.FmCompanyEntity;
import com.l024.finance.entity.SysMenuEntity;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * 公司详情
 */
public interface FmCompanyRepository extends JpaRepository<FmCompanyEntity,Long> {
}
