package jee.support.dao;

import jee.support.entity.Role;
import jee.support.entity.UserScore;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface UserScoreDao {


    void insertSudukoScoreByUsername(UserScore userScore);


    String CheckfinishSudukoByUsername(UserScore userScore);

    @Select("select answer from sudukoanswer where id =#{sudukoid}")
    String getSudukoAnswerByid(Integer sudukoid);


    @Select("select finishSuduko from userscore where sudukoid =#{id}")
    String getUserAnswerByid(int id);
}
