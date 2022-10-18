package jee.support.dao;

import com.github.pagehelper.PageInfo;
import jee.support.entity.CUSER;
import jee.support.entity.Comment;
import jee.support.entity.Head_portrait;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

//UserDao接口类,封装对User对象CRUD操作
public interface CUserDao {

    //根据id获取用户对象,如果不存在返回null
    public CUSER getUserById(long id);

    // 添加用户,返回新添加的用户id
    void insertUser(CUSER cuser);


    //校验是否存在该用户,不存在则返回null,存在则返回用户
    //使用@Param来传递参数,传入参数为username和password
    public CUSER findByNameAndPwd(@Param("username") String username,
                                 @Param("password") String password);


    public void deleteUser(String  username);

    public CUSER findByUsername(String username);

    CUSER findByRealname(String realname);

    List<CUSER> find_usernameByintegral();

    //查询所有用户
    List<CUSER> pageQueryData(Map<String, Object> map);

    //获取分页的 总数
    int pageQueryCount(Map<String, Object> map);

    void updateUser(CUSER cuser);


    CUSER queryByUsername(String realname);

    void deleteUsers(Map<String, Object> map);

    @Select(" select roleid from role_user where realname= #{realname}")
    List<String> queryRoleidsByUsername(String realname);

    void insertUserRoles(Map<String, Object> map);

    void deleteUserRoles(Map<String, Object> map);

    //主页面的会员列表 按照届来查询  分页查询  异步
    List<CUSER> pageQueryDatatBysid(Map<String, Object> map);
    int pageQueryCountBysid(Map<String, Object> map);

    @Select("select * from user where username=#{username}")
    CUSER checkCuserScoreByusername(String username);

    void updateUserIntegralByusername(@Param("username") String username,@Param("sumIntegral") int sumIntegral);


    CUSER queryByCUsername(String username);


    CUSER findByUsernameOrRealname(@Param("realname") String realname,@Param("username")  String username);

    List<CUSER> integralByGid(Integer gid);

    @Select("select * from Comment where realname = #{reanlname}")
    List<Comment> getUserCommentByrealname(String realname);

//    UPDATE Person SET FirstName = 'Fred' WHERE LastName = 'Wilson'
    @Update("update user set gender=#{gender},department=#{department},major=#{major},grade=#{grade},id=#{id} where realname=#{realname}")
    void updateUserByrealname(CUSER cuser);


    @Update(" update user set password =#{password} where username=#{username} or realname=#{realname}")
    void updateUserPwd(CUSER cuser);

    @Select("select * from head_portrait where realname =#{rn}")
    Head_portrait findHead_portraitByrealname(String rn);


    /**
     * 小程序后端
     * */
    List<CUSER> find_usernameByintegralmini();
}

