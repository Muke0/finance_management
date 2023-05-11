package com.l024.finance.entity;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Objects;

@Data
@Entity
@Table(name = "fm_company")
@ApiModel(value="公司信息")
public class FmCompanyEntity {
    @Id
    @GeneratedValue(strategy =  GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String address;
    private Timestamp createTime;
    private String count;
    private Double money;
    private String icon;
}
