package jee.support.dao;

import jee.support.entity.Role;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

public interface RoleDao {

    void insertRolePermission(Map<String, Object> paramMap);
    void deleteRolePermissions(Map<String, Object> paramMap);
    @Select(" select * from role")
    List<Role> queryAll();

    List<Role> pageQueryData(Map<String, Object> map);

    int pageQueryCount(Map<String, Object> map);


    void insertRole(Role role);

    void updataRole(Role role);

    @Delete("delete from role where id = #{id}")
    void deleteRole(Integer id);

    @Select("select id from role where name = #{position}")
    int findnameByposition(String position);

    List<Integer> findnameByid(String username);


    @Select("select name from role where id=#{integer}")
    String findnameByroleid(Integer integer);

//    @Update("alter table role_permission AUTO_INCREMENT=1  where id = #{id}")
//    void clearAll(Map<String, Object> paramMap);

}
