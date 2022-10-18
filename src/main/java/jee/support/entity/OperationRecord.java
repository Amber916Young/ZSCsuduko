package jee.support.entity;

import lombok.Data;

import java.util.Date;

@Data
public class OperationRecord {
    private String OperateObject;
    private String Operate;
    private String UserRealname;
    private String OperateTime;
    private int OperateState;
    private int OperateObjectKey;

}
