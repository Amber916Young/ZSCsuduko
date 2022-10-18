package jee.support.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jee.support.dao.CommentDao;
import jee.support.dao.PublicDao;
import jee.support.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

//类,封装对ticket对象CRUD操作
@Service
public class CommentService {

    @Autowired
    CommentDao commentDao;

    public void InsertActivityAddcoment(Comment comment) {
        commentDao.InsertActivityAddcoment(comment);
    }

    public void DeleteActivityComment(String id) {
        commentDao.DeleteActivityComment(id);
    }

    public List<Comment> pageQueryActivityCommentData(Map<String, Object> map) {
        return commentDao.pageQueryActivityCommentData(map);
    }

    public int pageQueryActivityCommentCount(Map<String, Object> map) {
        return commentDao.pageQueryActivityCommentCount(map);
    }

    public int pageQueryCommentCount(Integer id) {
        return commentDao.pageQueryCommentCount(id);
    }

    public PageInfo<Comment> getCommentIndex(int page, int size, String realname) {
        PageHelper.startPage(page,size);

        List list=commentDao.getCommentIndex(realname);
        PageInfo<Comment> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    public void DeleteActivityCommentByaid(Integer id) {
        commentDao.DeleteActivityCommentByaid(id);
    }

    public void DeleteActivityCommentByaids(Map<String,Object> map) {
        commentDao.DeleteActivityCommentByaids(map);
    }
}

