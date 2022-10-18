package jee.support.dao;

import jee.support.entity.AdminPhoto;
import jee.support.entity.administrator;
import lombok.Data;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

public interface AdministratorDao {


    @Select("select * from administrator where id=#{id} order by sid ,grade asc")
    List<administrator> findAll(int id);

    void insertAdmin(administrator admin);

    @Select("select * from administrator where realname=#{realname} ")
    administrator findadminByRealname(String realname);

    void updateAdmin(administrator admin);

    @Delete("delete from administrator where realname=#{realname}")
    void deleteUserByRealname(String realname);

    void deleteUsers(Map<String, Object> map);

    @Select("select * from administrator where realname =#{id}")
    administrator getauser(String id);


    /**
     * 会干真实的头像
     * */
    @Select("select * from adminphoto where sno = #{sno} and realname=#{realname}")
    AdminPhoto CheckAdminPhotoBySno(AdminPhoto adminPhoto);
    @Delete("delete from adminphoto where sno = #{sno} and realname=#{realname}")
    void DeleteAdminPhotoBySno(AdminPhoto adminPhoto);
    @Insert("insert into adminphoto(sno,realname,fileName,mimeType,fileUrl,position,sid,id) values(#{sno},#{realname},#{fileName},#{mimeType},#{fileUrl},#{position},#{sid},#{id})")
    void addAdminPhoto(AdminPhoto adminPhoto);
    @Select("select * from adminphoto where sno = #{sno} and realname=#{realname}")
    AdminPhoto getPuser(administrator auser);
    @Select("select * from adminphoto order by sid asc")
    List<AdminPhoto> getAllPUser();
    @Delete("delete from role_user where realname=#{realname}")
    void deleteUserByRealnameRole_user(String realname);
}
