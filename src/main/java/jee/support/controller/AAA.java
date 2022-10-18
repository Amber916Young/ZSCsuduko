package jee.support.controller;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AAA {
    @RequestMapping(value = {"","/","shudu_main"})
    public String index(){
        return "redirect:/index/";
    }

    @RequestMapping(value = {"/test"})
    public String wx(){
        return "testwx";
    }
}
