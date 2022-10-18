package jee.support.service;


import jee.support.dao.UserScoreDao;
import jee.support.entity.UserScore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class UserScoreService {
    @Autowired
    UserScoreDao userScoreDao;
    public void insertSudukoScoreByUsername(UserScore userScore) {
        userScoreDao.insertSudukoScoreByUsername(userScore);

    }


    public String CheckfinishSudukoByUsername(UserScore userScore) {
        return userScoreDao.CheckfinishSudukoByUsername(userScore);
    }

    public String getSudukoAnswerByid(Integer sudukoid) {
        return userScoreDao.getSudukoAnswerByid(sudukoid);
    }

    public String getUserAnswerByid(int id) {
        return userScoreDao.getUserAnswerByid(id);
    }
}
