package jee.support.service;

import jee.support.dao.ScheduledTimerDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ScheduledTimerService {
    @Autowired
    ScheduledTimerDao scheduledTimerDao;

    public void deleteLog() {
        scheduledTimerDao.deleteLog();
    }
}
