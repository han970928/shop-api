package com.fh.shop.admin.param.log;

import com.fh.shop.admin.common.Page;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class LogSearch extends Page implements Serializable {
    private  String userName;
    private  String realName;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private  Date   startCurrDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private  Date   overCurrDate;
    private  Integer status;
    private  String  info;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public Date getStartCurrDate() {
        return startCurrDate;
    }

    public void setStartCurrDate(Date startCurrDate) {
        this.startCurrDate = startCurrDate;
    }

    public Date getOverCurrDate() {
        return overCurrDate;
    }

    public void setOverCurrDate(Date overCurrDate) {
        this.overCurrDate = overCurrDate;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }
}
