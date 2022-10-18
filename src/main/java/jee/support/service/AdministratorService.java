package jee.support.service;

import jee.support.dao.AdministratorDao;
import jee.support.dao.AllUserDao;
import jee.support.entity.AdminPhoto;
import jee.support.entity.CUSER;
import jee.support.entity.administrator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

//类,封装对ticket对象CRUD操作
@Service
public class AdministratorService {

    @Autowired
    AdministratorDao administratorDao;
    public List<administrator> findAll(int id) {
        return administratorDao.findAll(id);
    }


    public void insertAdmin(administrator admin) {
        administratorDao.insertAdmin(admin);
    }

    public administrator findadminByRealname(String realname) {
        return administratorDao.findadminByRealname(realname);
    }

    public void updateAdmin(administrator admin) {
         administratorDao.updateAdmin(admin);
    }

    public void deleteUserByRealname(String realname) {
        administratorDao.deleteUserByRealname(realname);
    }

    public void deleteUsers(Map<String, Object> map) {
        administratorDao.deleteUsers(map);
    }

    public administrator getauser(String id) {
        return administratorDao.getauser(id);
    }

    public AdminPhoto CheckAdminPhotoBySno(AdminPhoto adminPhoto) {
        return administratorDao.CheckAdminPhotoBySno(adminPhoto);
    }

    public void DeleteAdminPhotoBySno(AdminPhoto adminPhoto) {
        administratorDao.DeleteAdminPhotoBySno(adminPhoto);
    }

    public void addAdminPhoto(AdminPhoto adminPhoto) {
        administratorDao.addAdminPhoto(adminPhoto);
    }

    public AdminPhoto getPuser(administrator auser) {
        return administratorDao.getPuser(auser);
    }

    public List<AdminPhoto> getAllPUser() {
        return administratorDao.getAllPUser();
    }

    public void deleteUserByRealnameRole_user(String realname) {
        administratorDao.deleteUserByRealnameRole_user(realname);
    }
}

