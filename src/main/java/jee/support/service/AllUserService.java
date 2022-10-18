package jee.support.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jee.support.dao.AllUserDao;
import jee.support.dao.CUserDao;
import jee.support.entity.CUSER;
import jee.support.entity.Suduko;
import jee.support.entity.UserScore;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

//类,封装对ticket对象CRUD操作
@Service
public class AllUserService {

    @Autowired
    AllUserDao allUserDao;
    public void updateByUsername(CUSER cuser) {
        allUserDao.updateByUsername(cuser);
    }


    public PageInfo<UserScore> GetMyAllsuduko(int page, int size,String username) {
        PageHelper.startPage(page, size);
        List list = allUserDao.GetMyAllsuduko(username);
        PageInfo<UserScore> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    public String checkusername(@Param("username") String username, @Param("realname")  String realname) {
        return allUserDao.checkusername(username,realname);
    }

    public  CUSER QueryUserByrealname(String realname) {
        return allUserDao.QueryUserByrealname(realname);
    }

    public int updatePwdByrealname(@Param("realname")String realname,@Param("password")String password) {
        return allUserDao.updatePwdByrealname(realname,password);
    }
}

