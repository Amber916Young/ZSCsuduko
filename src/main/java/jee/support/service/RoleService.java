package jee.support.service;

import jee.support.dao.RoleDao;
import jee.support.entity.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class RoleService {
    @Autowired
    RoleDao roleDao;
    public void insertRolePermission(Map<String, Object> paramMap) {
//        roleDao.clearAll(paramMap);
        roleDao.deleteRolePermissions(paramMap);
        roleDao.insertRolePermission(paramMap);
    }

    public List<Role> queryAll() {
        return roleDao.queryAll();
    }

    public List<Role> pageQueryData(Map<String, Object> map) {
        return roleDao.pageQueryData(map);
    }

    public int pageQueryCount(Map<String, Object> map) {
        return roleDao.pageQueryCount(map);
    }

    public void insertRole(Role role) {
        roleDao.insertRole(role);
    }

    public void updataRole(Role role) {
        roleDao.updataRole(role);
    }

    public void deleteRole(Integer id) {
        roleDao.deleteRole(id);
    }

    public int findnameByposition(String position) {
        return roleDao.findnameByposition(position);
    }

    public List<Integer> findnameByid(String username) {
        System.out.println(username);
        return roleDao.findnameByid(username);
    }


    public String findnameByroleid(Integer integer) {
        return roleDao.findnameByroleid(integer);
    }
}
