package jee.support.dao;

import jee.support.entity.Account;
import jee.support.entity.Money;
import jee.support.entity.OperationRecord;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface OperationRecordMapperDao {


    void insertSelective(OperationRecord operationRecord);

    List<OperationRecord> pageQueryLogData(Map<String, Object> map);

    int pageQueryLogCount(Map<String, Object> map);
}
