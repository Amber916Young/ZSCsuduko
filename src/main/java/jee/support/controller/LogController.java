package jee.support.controller;


import jee.support.entity.AJAXResult;
import jee.support.entity.OperationRecord;
import jee.support.entity.Page;
import jee.support.entity.Suduko;
import jee.support.service.OperationRecordMapperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 日志  log表
 * */
@Controller
@RequestMapping("/log")
public class LogController {

    @Autowired
    OperationRecordMapperService operationRecordMapperService;
    @RequestMapping("/log")
    public String GotoLogPage(){
        return "/log/logindex";
    }

    @ResponseBody
    @RequestMapping("/OperationRecord/queryAll")
    public Object OperationRecordQueryAll(String queryText, Integer pageno, Integer pagesize){
        AJAXResult result = new AJAXResult();
//        System.out.println("pageno"+pageno+"  pagesize"+pagesize);
        try {
            Map<String, Object> map = new HashMap();
            map.put("start", (pageno - 1) * pagesize);
            map.put("size", pagesize);
            map.put("queryText", queryText);
            List<OperationRecord> operationRecords = this.operationRecordMapperService.pageQueryLogData(map);
            int totalsize = this.operationRecordMapperService.pageQueryLogCount(map);
//            System.out.println("totalsize::::"+totalsize);
            int totalno = 0;

            if (totalsize % pagesize == 0) {
                totalno = totalsize / pagesize;
            } else {
                totalno = totalsize / pagesize + 1;
            }
            Page<OperationRecord> operationRecordPage = new Page();
            operationRecordPage.setDatas(operationRecords);
            operationRecordPage.setTotalno(totalno);
            operationRecordPage.setTotalsize(totalsize);
            operationRecordPage.setPageno(pageno);
            result.setData(operationRecordPage);
            result.setSuccess(true);
        } catch (Exception var10) {
            var10.printStackTrace();
            result.setSuccess(false);
        }
        return result;

    }
}
