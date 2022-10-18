package jee.support.entity;

import lombok.Data;

@Data
public class Announcement {
    private int id;
    private int gid;
    private String content;
    private String time;
    private String realname;
    private int status;
}
