package jee.support.service;

import com.github.pagehelper.PageInfo;
import jee.support.dao.CUserDao;
import jee.support.entity.CUSER;
import jee.support.entity.Comment;
import jee.support.entity.Head_portrait;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

//TicketDao类,封装对ticket对象CRUD操作
@Service
public class CUserService {

    @Autowired
    CUserDao cuserDao;


    //获取用户
    public CUSER getUser(long id) {
        return cuserDao.getUserById(id);
    }




    @Transactional
    public void deleteUserById(String username) {
        cuserDao.deleteUser(username);
    }
    //校验是否存在该用户,不存在则返回null,存在则返回用户
    //使用@Param来传递参数,传入参数为username和password
    public CUSER authenticate(String username, String password) {
        return cuserDao.findByNameAndPwd(username, password);
    }
    public CUSER findByUsername(String username) {
        return cuserDao.findByUsername(username);
    }
    public List<CUSER> find_usernameByintegral() {
        return cuserDao.find_usernameByintegral();
    }


    public List<CUSER> pageQueryData(Map<String, Object> map) {
        return cuserDao.pageQueryData(map);
    }

    public int pageQueryCount(Map<String, Object> map) {
        return cuserDao.pageQueryCount(map);
    }

    // 添加用户
    public void insertUser(CUSER cuser) {
        cuserDao.insertUser(cuser);
    }

    public void updateUser(CUSER cuser) {
        cuserDao.updateUser(cuser);
    }

    public CUSER queryByUsername(String realname) {
        return cuserDao.queryByUsername(realname);
    }
    public CUSER queryByCUsername(String username) {
        return cuserDao.queryByCUsername(username);
    }
    public void deleteUsers(Map<String, Object> map) {
        cuserDao.deleteUsers(map);
    }

    public List<String> queryRoleidsByUsername(String realname) {
        return  cuserDao.queryRoleidsByUsername(realname);
    }

    public void insertUserRoles(Map<String, Object> map) {
        cuserDao.insertUserRoles(map);
    }

    public void deleteUserRoles(Map<String, Object> map) {
        cuserDao.deleteUserRoles(map);
    }


    //主页面的 会员列表
    public List<CUSER> pageQueryDatatBysid(Map<String, Object> map) {
       return cuserDao.pageQueryDatatBysid(map);
    }

    public int pageQueryCountBysid(Map<String, Object> map) {
        return  cuserDao.pageQueryCountBysid(map);
    }

    public CUSER checkCuserScoreByusername(String username) {
        return cuserDao.checkCuserScoreByusername(username);
    }

    public void updateUserIntegralByusername(String username, int sumIntegral) {
        cuserDao.updateUserIntegralByusername(username,sumIntegral);
    }


    public CUSER findByRealname(String realname) {
        return cuserDao.findByRealname(realname);
    }

    public CUSER findByUsernameOrRealname(@Param("realname") String realname,@Param("username")  String username) {
        return cuserDao.findByUsernameOrRealname(realname,username);
    }

    public List<CUSER> integralByGid(Integer gid) {
        return cuserDao.integralByGid(gid);
    }

    public List<Comment> getUserCommentByrealname(String realname) {
        return cuserDao.getUserCommentByrealname(realname);
    }

    public void updateUserByrealname(CUSER cuser) {
        cuserDao.updateUserByrealname(cuser);
    }


    public void updateUserPwd(CUSER cuser) {
        cuserDao.updateUserPwd(cuser);
    }

    public Head_portrait findHead_portraitByrealname(String rn) {
        return cuserDao.findHead_portraitByrealname(rn);
    }



    /**
     * 小程序后端
     * */
    public List<CUSER> find_usernameByintegralmini() {
      return  cuserDao.find_usernameByintegralmini();
    }
}

