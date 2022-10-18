package jee.support.dao;


import org.apache.ibatis.annotations.Delete;

public interface ScheduledTimerDao {


    @Delete("delete from operationrecord")
    void deleteLog();
}
