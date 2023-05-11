package com.l024.finance.repository;

import com.l024.finance.entity.FmNoticeEntity;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * 公司留言
 */
public interface FmNoticeRepository extends PagingAndSortingRepository<FmNoticeEntity,Long> {
}
