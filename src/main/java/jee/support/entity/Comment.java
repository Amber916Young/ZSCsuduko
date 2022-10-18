package jee.support.entity;

import lombok.Data;

@Data
public class Comment {
    private int id;
    private int aid;
    private String username;
    private String content;
    private String time;
    private String realname;
    private String aurl;
    private String atitle;
    private String hurl;
}
