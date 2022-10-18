package jee.support.entity;

import lombok.Data;

@Data
public class Money {
    private  int id;//是account gid外键
    private  double account_money; //总金额 记录每一届的总收入

}
