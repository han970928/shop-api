package com.fh.shop.admin.biz.log;


import com.fh.shop.admin.common.DateTable;
import com.fh.shop.admin.param.log.LogSearch;
import com.fh.shop.admin.po.log.Log;

public interface ILogService {
    void addLog(Log log);
    DateTable queryLogList(LogSearch logSearch);
}
