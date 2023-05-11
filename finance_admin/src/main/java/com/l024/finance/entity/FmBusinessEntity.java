package com.l024.finance.entity;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "fm_business")
@ApiModel(value="部门信息")
public class FmBusinessEntity {
    @Id
    @GeneratedValue(strategy =  GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String note;
    private Byte state;
    private Double money;
    private String startTime;
    private String endTime;

    //部门id
    @ManyToOne(targetEntity = FmDepartmentEntity.class)
    @JoinColumn(name = "department_id",referencedColumnName = "id")
    private FmDepartmentEntity department;

}
