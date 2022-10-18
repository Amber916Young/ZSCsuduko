package jee.support.entity;

import lombok.Data;

@Data
public class Preview {
    private int id;
    private int aid;
    private String url;
    private String content;
    private String title;
}
