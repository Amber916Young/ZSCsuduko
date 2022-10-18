package jee.support.dao;

import jee.support.entity.Account;
import jee.support.entity.Money;
import jee.support.entity.Timing;
import lombok.Data;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface TimingDao {


    void inserttiming(Timing timing);

    int updatestatus(String time);

    @Select("select * from timing where status=1")
    List<Timing> getAllStatus();

    @Select("select * from timing where oid=#{id}")
    HashMap<String, Object> QueryTimingById(int id);

    @Delete("delete from timing where oid= #{id} and type=#{type}")
    int deleteBeforeByOid(@Param("id") int id,@Param("type") String type);



    int deleteBeforeByMap(Map<String, Object> map);


    @Select("select * from timing where oid=#{id} and type=#{typpe} order by time desc limit 10")
    Timing gettimeByoid(@Param("id") int id, @Param("typpe") String typpe);
}
