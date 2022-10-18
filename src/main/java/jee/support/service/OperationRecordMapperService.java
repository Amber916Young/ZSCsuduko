package jee.support.service;

import jee.support.dao.AccountDao;
import jee.support.dao.OperationRecordMapperDao;
import jee.support.entity.Account;
import jee.support.entity.Money;
import jee.support.entity.OperationRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

//类,封装对ticket对象CRUD操作
@Service
public class OperationRecordMapperService {

    @Autowired
    OperationRecordMapperDao operationRecordMapperDao;

    public void insertSelective(OperationRecord operationRecord) {
        operationRecordMapperDao.insertSelective(operationRecord);
    }

    public List<OperationRecord> pageQueryLogData(Map<String, Object> map) {
        return operationRecordMapperDao.pageQueryLogData(map);
    }

    public int pageQueryLogCount(Map<String, Object> map) {
        return operationRecordMapperDao.pageQueryLogCount(map);
    }
}

