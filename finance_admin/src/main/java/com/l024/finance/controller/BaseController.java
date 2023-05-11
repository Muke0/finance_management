package com.l024.finance.controller;

import com.l024.finance.vo.R;

public interface BaseController<T> {
    R add(T t);
    R del(Long id);
    R update(T t);
    R getAll();
    R get(T t);
}
