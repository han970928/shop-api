package com.fh.shop.admin.mapper.log;

import com.fh.shop.admin.param.log.LogSearch;
import com.fh.shop.admin.po.log.Log;

import java.util.List;


public interface ILogMapper {
    void addLog(Log log);
    List<Log> queryLogList(LogSearch logSearch);
    Integer queryCount(LogSearch logSearch);
}
