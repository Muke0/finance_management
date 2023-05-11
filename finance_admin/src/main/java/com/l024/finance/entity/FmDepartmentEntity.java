package com.l024.finance.entity;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.persistence.*;
import java.sql.Timestamp;

@Data
@Entity
@Table(name = "fm_department")
@ApiModel(value="部门信息")
public class FmDepartmentEntity {
    @Id
    @GeneratedValue(strategy =  GenerationType.IDENTITY)
    private Long id;
    private String name;
    private Timestamp createTime;
    private String note;
    private Double money;//工资
    private Double businessAmount;//业务金额
}
