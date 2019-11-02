package com.fh.shop.admin.biz.log;

import com.fh.shop.admin.common.DateTable;
import com.fh.shop.admin.mapper.log.ILogMapper;
import com.fh.shop.admin.param.log.LogSearch;
import com.fh.shop.admin.po.log.Log;
import com.fh.shop.admin.po.shop.Shop;
import com.fh.shop.admin.utils.DateAndString;
import com.fh.shop.admin.vo.log.LogVo;
import com.fh.shop.admin.vo.shop.ShopVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("logService")
public class ILogServiceImpl implements ILogService {
    @Autowired
    private ILogMapper logMapper;

    @Override
    public void addLog(Log log) {
        logMapper.addLog(log);
    }

    @Override
    public DateTable queryLogList(LogSearch logSearch) {
        Integer count=logMapper.queryCount(logSearch);
        List<Log> logList = logMapper.queryLogList(logSearch);
        List<LogVo> logVos=new ArrayList<>();
        for (Log log : logList) {
            LogVo logVo=getLogVo(log);
            logVos.add(logVo);
        }
        DateTable dateTable=new DateTable(logSearch.getDraw(),count,count,logVos);
        return dateTable;
    }
    private LogVo getLogVo(Log log) {
        LogVo vo=new LogVo();
        vo.setUserName(log.getUserName());
        vo.setRealName(log.getRealName());
        vo.setCurrDate(DateAndString.date2String(log.getCurrDate(),DateAndString.Y_M_D_H_M));
        vo.setInfo(log.getInfo());
        vo.setStatus(log.getStatus());
        vo.setErrorMsg(log.getErrorMsg());
        vo.setDetail(log.getDetail());
        vo.setContent(log.getContent());
        return vo;
    }
}
