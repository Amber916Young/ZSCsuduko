package jee.support.dao;

import jee.support.entity.CUSER;
import jee.support.entity.Suduko;
import jee.support.entity.UserScore;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface AllUserDao {
    void updateByUsername(CUSER cuser);


    @Select("select * from userscore where username =#{username} order by finishTime desc")
    public List<UserScore> GetMyAllsuduko(String username);


    String checkusername(@Param("username") String username,@Param("realname")  String realname);

    @Select("select * from user where realname = #{realname}")
    CUSER QueryUserByrealname(String realname);


    int updatePwdByrealname(@Param("realname") String realname,@Param("password") String password);
}
