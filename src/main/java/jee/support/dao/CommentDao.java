package jee.support.dao;


import com.github.pagehelper.PageInfo;
import jee.support.entity.Comment;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface CommentDao {


    void InsertActivityAddcoment(Comment comment);

    @Delete("delete from comment where id = #{id}")
    void DeleteActivityComment(String id);

    List<Comment> pageQueryActivityCommentData(Map<String, Object> map);

    int pageQueryActivityCommentCount(Map<String, Object> map);

    @Select("select count(*) from comment where aid=#{id}")
    int pageQueryCommentCount(Integer id);

    @Select("select * from comment where realname = #{realname} order by time desc")
    List<Comment> getCommentIndex( String realname);

    @Delete("delete from comment where aid = #{id}")
    void DeleteActivityCommentByaid(Integer id);

    void DeleteActivityCommentByaids(Map<String,Object> map);
}
