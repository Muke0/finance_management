package com.l024.finance.repository;

import com.l024.finance.entity.FmMoneyTypeEntity;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * 支出/收入标签
 */
public interface FmMoneyTypeRepository extends JpaRepository<FmMoneyTypeEntity,Long> {
    FmMoneyTypeEntity findFmMoneyTypeEntityByName(String name);
}
