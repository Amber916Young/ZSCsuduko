package jee.support.controller;

import jee.support.entity.*;
import jee.support.service.CUserService;
import jee.support.service.UserScoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;


/**
 * 用户分数统计
 **/
@Controller
@RequestMapping("/userscore")
public class UserScoreController {
    @Autowired
    UserScoreService userScoreService;
    @Autowired
    CUserService cUserService;



    /**
     * 检查做完情况，记录题号，时间，用户名等信息
     **/
    @ResponseBody
    @RequestMapping(value = "/checkfinish",method = RequestMethod.POST)
    public Object CheckfinishSudukoByUsername(String username, Integer sudukoid){
        AJAXResult result = new AJAXResult();
        try {
            if(username==null||username==""){
                result.setData(null);
            }else{
                UserScore userScore = new UserScore();
                userScore.setUsername(username);
                userScore.setSudukoid(sudukoid);
                String finishSuduko =this.userScoreService.CheckfinishSudukoByUsername(userScore);
                if (finishSuduko==null){
                    result.setData(null);
                }
                result.setData(finishSuduko);
            }
            result.setSuccess(true);
        } catch (Exception var10) {
            var10.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    /**
     * 更新用户做题积分
     **/
    @ResponseBody
    @RequestMapping(value = "/upload",method = RequestMethod.POST)
    public Object UploadSudukoScoreByUsername(String username, Integer sudukoid,String totaltime,Integer score,String finishSuduko){
        AJAXResult result = new AJAXResult();
        System.out.println("username"+username+"  score"+score);
        try {
            UserScore userScore = new UserScore();
            Suduko suduko = new Suduko();
            RandomNumber randomNumber = new RandomNumber();
            int id = randomNumber.CreateRandomNumber();
            Date ltime = new Date();
            SimpleDateFormat format0 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String finishTime =format0.format(ltime.getTime());
            userScore.setId(id);
            userScore.setSudukoid(sudukoid);
            userScore.setUsername(username);
            userScore.setTotaltime(totaltime);
            String answer = userScoreService.getSudukoAnswerByid(sudukoid);
            System.out.println("myaaannnsss"+finishSuduko);
            System.out.println("aaaaannnnsss"+answer);

            userScore.setFinishSuduko(finishSuduko);
            userScore.setFinishTime(finishTime);
            HashMap<String ,String> hashMap = new HashMap<String ,String>();
            CUSER cuser = this.cUserService.checkCuserScoreByusername(username);
            int Integral=cuser.getIntegral();
            int sumIntegral=0;
            if(answer.equals(finishSuduko)){
                System.out.println("答案正确");
                sumIntegral= score+Integral;
//                wrong and right
                hashMap.put("wAr","right");
                userScore.setRightorno(1);
            }else{
                sumIntegral=Integral;
                System.out.println("答案错误");
                userScore.setRightorno(0);
                hashMap.put("wAr","wrong");
                hashMap.put("answer",answer);

            }
            result.setData(hashMap);
            this.userScoreService.insertSudukoScoreByUsername(userScore);
            //当写完每一题都要更新用户的积分，当然要查询用户之前的积分是多少再加上去
            System.out.println("sumIntegral"+sumIntegral);
            cUserService.updateUserIntegralByusername(username,sumIntegral);

            result.setSuccess(true);
        } catch (Exception var10) {
            var10.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

}
