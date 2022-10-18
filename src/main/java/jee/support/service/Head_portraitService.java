package jee.support.service;


import jee.support.dao.Head_portraitDao;
import jee.support.entity.CUSER;
import jee.support.entity.Head_portrait;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class Head_portraitService {

    @Autowired
    Head_portraitDao head_portraitDao;

    public void addHead_portrait(Head_portrait head_portrait) {

        head_portraitDao.addHead_portrait(head_portrait);
    }

    public Head_portrait checkUsername(Head_portrait head_portrait) {
        return head_portraitDao.checkUsername(head_portrait);
    }

    public void deleteHead_portrait(Head_portrait head_portrait) {
        head_portraitDao.deleteHead_portrait(head_portrait);
    }

    public Head_portrait selectAllmessage(String realname) {
        return head_portraitDao.selectAllmessage(realname);
    }


    public String getHead_portrait(String realname) {
       return head_portraitDao.getHead_portrait(realname);
    }
}
