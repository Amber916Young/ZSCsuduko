package jee.support.entity;

import lombok.Data;

@Data
public class UserScore {
    private int id;
    private String username;
    private int sudukoid;  //题号
    private String totaltime;
    private String finishSuduko;
    private String finishTime; //用户完成时间
    private int rightorno;
}
