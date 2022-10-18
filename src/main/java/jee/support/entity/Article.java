package jee.support.entity;

import lombok.Data;

@Data
public class Article {
    //活动时间，内容，标题，发布者
    private String name; //发布者 必须真实姓名
    private String time;
    private String content;
    private String title;
    private int id;  //唯一标识符
    private String url; //文章链接
    private int status;
    private String typemsg; //具体种类名称
    private String type;

}
