package jee.support.service;

import jee.support.dao.AccountDao;
import jee.support.dao.TimingDao;
import jee.support.entity.Account;
import jee.support.entity.Money;
import jee.support.entity.Timing;
import org.apache.ibatis.annotations.Param;
import org.omg.Messaging.SYNC_WITH_TRANSPORT;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

//类,封装对ticket对象CRUD操作
@Service
public class TimingService {

    @Autowired
    TimingDao timingDao;


    public void inserttiming(Timing timing) {
        timingDao.inserttiming(timing);
    }

    public int updatestatus(String time) {
        return timingDao.updatestatus(time);
    }

    public List<Timing> getAllStatus() {
        return timingDao.getAllStatus();
    }

    public HashMap<String, Object> QueryTimingById(Integer id) {
        return timingDao.QueryTimingById(id);
    }

    public int deleteBeforeByOid(@Param("id") Integer id,@Param("type")  String type) {
        System.out.println(id+"   "+type);
        return timingDao.deleteBeforeByOid(id,type);
    }
    public int deleteBeforeByMap(Map<String, Object> map) {
        return timingDao.deleteBeforeByMap(map);
    }


    public Timing gettimeByoid(@Param("id") int id,   @Param("typpe")  String typpe) {
        return timingDao.gettimeByoid(id,typpe);
    }
}

