package jee.support.entity;

import lombok.Data;

@Data
public class SudukoImg {
    private int id;
    private int sid;
    private String fileName;
    private String mimeType;
    private String fileUrl;
    private String type;
}
