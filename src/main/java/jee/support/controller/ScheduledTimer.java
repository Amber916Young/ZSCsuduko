package jee.support.controller;

import javafx.concurrent.ScheduledService;
import jee.support.service.CUserService;
import jee.support.service.PublicService;
import jee.support.service.ScheduledTimerService;
import jee.support.service.TimingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Date;

//TODO 请忽略
@Component
public class ScheduledTimer {
    @Autowired
    CUserService cuserService;
    @Autowired
    PublicService publicService;
    @Autowired
    TimingService timingService;
    @Autowired
    ScheduledTimerService scheduledTimerService;

//    @Scheduled(cron = "*/5 * * * * ?")
    @Scheduled(cron = "0 0 0 1 1-12 ? ")
    public void myTask() {
        //半个月删除一次日志
        scheduledTimerService.deleteLog();
        System.out.println(" myTask 每个月一号零点  删除一次日志. Current time is :: " + (new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date()));
    }

//    @Scheduled(cron = "0 0 23 ? * L ")
//    @Scheduled(cron = "*/10 * * * * ?")
//    public void myTask2() {
//        //每周记录一次排名
////        scheduledTimerService.queryRankByWeek();
//        System.out.println("myTask2每周记录一次排名 . Current time is :: " + (new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date()));
//    }
}
