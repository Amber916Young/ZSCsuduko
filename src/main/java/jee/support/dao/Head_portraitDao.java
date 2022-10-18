package jee.support.dao;

import jee.support.entity.CUSER;
import jee.support.entity.Head_portrait;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface  Head_portraitDao {


    void addHead_portrait(Head_portrait head_portrait);

    void deleteHead_portrait(Head_portrait head_portrait);

    @Select("select * from  head_portrait where realname=#{realname}")
    Head_portrait checkUsername(Head_portrait head_portrait);

    @Select("select * from  head_portrait where realname=#{realname}")
    Head_portrait selectAllmessage(String realname);


    @Select("select fileUrl from head_portrait where realname=#{realname}")
    String getHead_portrait(String realname);
}
