package jee.support.entity;

import lombok.Data;

import java.util.List;

@Data
public class Suduko {
    private int id;
    private String num;
    private String type;  //数独类型  标准九宫
    private String difficulty_level;  //难度
    private int score;
    private String time;
    private String url;
    private int status;
    List<SudukoImg> sudukoImgs;
}
