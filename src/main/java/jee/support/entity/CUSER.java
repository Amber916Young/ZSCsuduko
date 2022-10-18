package jee.support.entity;

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class CUSER {

    private  String realname; //真实姓名不可更改
    private String username;  //用户名
    private String email;   //邮箱
    private String password; //密码
    private String gender;  //性别
    private String tel;     //电话
    private String department;   //学院
    private String sno;     //学号
    private String major;   //专业
    private int level;      //等级
//    private String head_portrait;//头像 url

    private int integral;// 积分
    private String userUrl;//用户主页的url
    private String createtime;   //创建时间
    private  String sign;  //用户签名
    List<Head_portrait> head_portrait; //附件列表 头像 url
    private  int id;  //表示入会时间20  19 20 21
    private  int grade;
}
