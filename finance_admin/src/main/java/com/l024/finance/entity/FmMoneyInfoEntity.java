package com.l024.finance.entity;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.persistence.*;
import java.sql.Timestamp;

@Data
@Entity
@Table(name = "fm_money_info")
@ApiModel(value="收入支出详情信息")
public class FmMoneyInfoEntity {
    @Id
    @GeneratedValue(strategy =  GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String note;
    private Double money;
//    private Long userId;
//    private Long money_type_id;
    private Timestamp createTime;

    /**
     * 配置联系人到客户的多对一的关系
     *  1.配置表关系
     *       @ManyToOne
     *          配置多对一关系
     *              targetEntity：对方实体类字节码
     *  2.配置外键
     *          name:外键字段名称
     *          referencedColumnName：参照的主表的主键字段名称
     * @return
     */
    @ManyToOne(targetEntity = SysUserEntity.class)
    @JoinColumn(name = "user_id",referencedColumnName = "id")
    private SysUserEntity user;

    @ManyToOne(targetEntity = FmMoneyTypeEntity.class)
    @JoinColumn(name = "money_type_id",referencedColumnName = "id")
    private FmMoneyTypeEntity moneyType;
}
