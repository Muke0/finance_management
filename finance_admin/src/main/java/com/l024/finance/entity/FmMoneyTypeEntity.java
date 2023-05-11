package com.l024.finance.entity;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "fm_money_type")
@ApiModel(value="支出收入信息")
public class FmMoneyTypeEntity {
    @Id
    @GeneratedValue(strategy =  GenerationType.IDENTITY)
    private Long id;
    private String name;
    private Byte type;

}
