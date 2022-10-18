package jee.support.entity;

import lombok.Data;

@Data
public class Timing {
    private int id;
    private int oid;
    private int status;
    private String time;
    private String optime;
    private String type;
}
