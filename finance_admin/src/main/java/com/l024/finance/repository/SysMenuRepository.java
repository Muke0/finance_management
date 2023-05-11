package com.l024.finance.repository;

import com.l024.finance.entity.SysMenuEntity;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * 菜单
 */
public interface SysMenuRepository extends JpaRepository<SysMenuEntity,Long> {
}
