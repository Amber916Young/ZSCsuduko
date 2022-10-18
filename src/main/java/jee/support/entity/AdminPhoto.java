package jee.support.entity;

import lombok.Data;

@Data
public class AdminPhoto {
    private String sno;
    private String realname;
    private String fileName;
    private String mimeType;
    private String fileUrl;
    private String position;
    private int sid;  //职位对应的编号
    private int id; //第几届的会干
}
