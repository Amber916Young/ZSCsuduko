package jee.support.service;

import jee.support.dao.PermissionDao;
import jee.support.entity.CUSER;
import jee.support.entity.Permission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PermissionService {
    @Autowired
    PermissionDao permissionDao;

    public Permission queryRootPermission() {
        return permissionDao.queryRootPermission();
    }

    public List<Permission> queryChildPermissions(Integer pid) {
        return permissionDao.queryChildPermissions(pid);
    }

    public void insertPermission(Permission permission) {
        permissionDao.insertPermission(permission);
    }

    public void updatePermission(Permission permission) {
        permissionDao.updatePermission(permission);
    }

    //根据id 查询这个权限
    public Permission queryById(Integer id) {
        return permissionDao.queryById(id);
    }

    public void deletePermission(Permission permission) {
//        System.out.println("public void deletePermission(Permission permission"+permission);
         permissionDao.deletePermission(permission);
    }

    public List<Permission> queryAll() {
        return permissionDao.queryAll();
    }

    public List<Integer> queryPermissionidsByRoleid(Integer roleid) {
        return permissionDao.queryPermissionidsByRoleid(roleid);
    }

    public List<Permission> queryPermissionsByUser(CUSER dbUser) {
        return permissionDao.queryPermissionsByUser(dbUser);
    }
}
