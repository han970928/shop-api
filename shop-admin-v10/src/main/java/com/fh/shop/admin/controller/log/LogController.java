package com.fh.shop.admin.controller.log;

import com.fh.shop.admin.biz.log.ILogService;
import com.fh.shop.admin.common.DateTable;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.log.LogSearch;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
@RequestMapping("/log")
public class LogController {
    @Resource(name="logService")
    private ILogService logService;

    @RequestMapping("/toList")
    public String toList(){
        return "/log/list";
    }

    @RequestMapping("/queryLogList")
    @ResponseBody
    public DateTable queryLogList(LogSearch logSearch){
        DateTable dateTable=logService.queryLogList(logSearch);
        return dateTable;
    }

}
