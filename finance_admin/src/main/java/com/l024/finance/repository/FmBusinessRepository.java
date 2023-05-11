package com.l024.finance.repository;

import com.l024.finance.entity.FmBusinessEntity;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * 业务
 */
public interface FmBusinessRepository extends PagingAndSortingRepository<FmBusinessEntity,Long> {
}
