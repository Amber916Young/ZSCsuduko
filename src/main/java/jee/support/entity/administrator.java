package jee.support.entity;
import lombok.Data;

@Data
public class administrator {
    private int id;           //表示第几届的会干
    private String realname;    //真实姓名
    private String gender;      //性别
    private String department;  //学院
    private String major;       //专业
    private String sno;         //学号
    private String position;     //职位
    private int grade;       //年级
    private int sid;            //role对应的职位


}
