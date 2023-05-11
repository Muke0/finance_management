package com.l024.finance.repository;

import com.l024.finance.entity.FmMoneyInfoEntity;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * 收入支出详情
 */
public interface FmMoneyInfoRepository extends PagingAndSortingRepository<FmMoneyInfoEntity,Long> {
}
