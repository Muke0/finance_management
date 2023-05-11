package com.l024.finance.service;

import com.l024.finance.repository.SysUserRepository;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
class SysUserServiceTest {
    @Autowired
    private SysUserRepository sysUserRepository;
    @Test
    void add() {
//        List<SysUserEntity> all = sysUserRepository.findAll();
//        System.out.println(all);
    }
}