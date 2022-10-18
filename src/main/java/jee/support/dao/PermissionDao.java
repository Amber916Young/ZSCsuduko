package jee.support.dao;

import jee.support.entity.CUSER;
import jee.support.entity.Permission;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface PermissionDao {


    void insertPermission(Permission permission);

    @Select("select * from permission where pid =0")
    Permission queryRootPermission();

    @Select("select * from permission where pid =#{pid}")
    List<Permission> queryChildPermissions(Integer pid);

    void updatePermission(Permission permission);

    @Select( "select * from permission where id = #{id}")
    Permission queryById(Integer id);

    @Delete("delete from permission where id = #{id}")
    void deletePermission(Permission permission);

    @Select("select * from permission")
    List<Permission> queryAll();

    @Select({"select permissionid from role_permission where roleid = #{roleid}"})
    List<Integer> queryPermissionidsByRoleid(Integer roleid);

    List<Permission> queryPermissionsByUser(CUSER dbUser);

}
