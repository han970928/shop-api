package com.fh.shop.admin.param.user;

import com.fh.shop.admin.common.Page;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UserSearch extends Page implements Serializable {
    private  String userName;
    private  String roleName;
    private  Integer minAge;
    private  Integer maxAge;
    private  Double mincompensation;
    private  Double maxcompensation;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private  Date   minhiredate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private  Date   maxhiredate;
    private  String roleIds;
    private  List<Integer>  roleList=new ArrayList<>();
    private  Integer  roleSize;
    private  Integer areaId1;
    private  Integer areaId2;
    private  Integer areaId3;


    public Integer getAreaId1() {
        return areaId1;
    }

    public void setAreaId1(Integer areaId1) {
        this.areaId1 = areaId1;
    }

    public Integer getAreaId2() {
        return areaId2;
    }

    public void setAreaId2(Integer areaId2) {
        this.areaId2 = areaId2;
    }

    public Integer getAreaId3() {
        return areaId3;
    }

    public void setAreaId3(Integer areaId3) {
        this.areaId3 = areaId3;
    }

    public Integer getRoleSize() {
        return roleSize;
    }

    public void setRoleSize(Integer roleSize) {
        this.roleSize = roleSize;
    }

    public String getRoleIds() {
        return roleIds;
    }

    public void setRoleIds(String roleIds) {
        this.roleIds = roleIds;
    }

    public List<Integer> getRoleList() {
        return roleList;
    }

    public void setRoleList(List<Integer> roleList) {
        this.roleList = roleList;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public Integer getMinAge() {
        return minAge;
    }

    public void setMinAge(Integer minAge) {
        this.minAge = minAge;
    }

    public Integer getMaxAge() {
        return maxAge;
    }

    public void setMaxAge(Integer maxAge) {
        this.maxAge = maxAge;
    }

    public Double getMincompensation() {
        return mincompensation;
    }

    public void setMincompensation(Double mincompensation) {
        this.mincompensation = mincompensation;
    }

    public Double getMaxcompensation() {
        return maxcompensation;
    }

    public void setMaxcompensation(Double maxcompensation) {
        this.maxcompensation = maxcompensation;
    }

    public Date getMinhiredate() {
        return minhiredate;
    }

    public void setMinhiredate(Date minhiredate) {
        this.minhiredate = minhiredate;
    }

    public Date getMaxhiredate() {
        return maxhiredate;
    }

    public void setMaxhiredate(Date maxhiredate) {
        this.maxhiredate = maxhiredate;
    }
}
