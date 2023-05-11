package com.l024.finance.service;

import com.l024.finance.vo.R;

import java.util.List;

public interface BaseService<T> {
    boolean add(T t);
    boolean del(long id);
    List<T> getAll();
    boolean update(T t);
}
