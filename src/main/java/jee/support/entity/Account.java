package jee.support.entity;


import lombok.Data;

import java.util.Date;

@Data
public class Account {
    private int id;         //类似于票据管理系统的唯一标识符 id
    private int gid;        //届数
    private String name;   // 活动名称
    private String detail; //活动明细
    private double expenditure;//活动花费
    private String time;      //活动时间
    private double balance;   //活动花费
    private String pname;   //活动经手人
}
