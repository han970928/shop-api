package com.fh.shop.admin.po.user;

import com.baomidou.mybatisplus.annotation.TableField;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class UserPo  implements Serializable {
    private  Long  id;
    private  String userName;
    private  String roleName;
    private  String password;
    private  Integer age;
    private  String  email;
    private  Integer sex;
    private  String  phone;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private  Date    hiredate; //入职时间
    private BigDecimal compensation; //薪资
    private  String  roleids;//角色
    private  Integer tocount;//登录次数
    private  Date    loginDate;//登录时间
    @TableField(exist = false)// 不对应数据库,前台展示用
    private  String    loginDateString;//登录时间
    private  Integer errorCount;
    private  Date    errorDate;
    private  String  salt;
    private  String  imgFilePath;
    private  Integer areaId1;
    private  Integer areaId2;
    private  Integer areaId3;
    @TableField(exist = false)// 不对应数据库,前台展示用
    private  String  areaName;
    @TableField(exist = false)// 不对应数据库,前台展示用
    private  String  imgCode;


    public String getImgCode() {
        return imgCode;
    }

    public void setImgCode(String imgCode) {
        this.imgCode = imgCode;
    }

    public String getAreaName() {
        return areaName;
    }

    public void setAreaName(String areaName) {
        this.areaName = areaName;
    }

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

    public Date getErrorDate() {
        return errorDate;
    }

    public void setErrorDate(Date errorDate) {
        this.errorDate = errorDate;
    }

    public String getImgFilePath() {
        return imgFilePath;
    }
    public void setImgFilePath(String imgFilePath) {
        this.imgFilePath = imgFilePath;
    }
    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public Integer getErrorCount() {
        return errorCount;
    }

    public void setErrorCount(Integer errorCount) {
        this.errorCount = errorCount;
    }

    public Date getLoginDate() {
        return loginDate;
    }

    public void setLoginDate(Date loginDate) {
        this.loginDate = loginDate;
    }

    public Integer getTocount() {
        return tocount;
    }

    public void setTocount(Integer tocount) {
        this.tocount = tocount;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getHiredate() {
        return hiredate;
    }

    public void setHiredate(Date hiredate) {
        this.hiredate = hiredate;
    }

    public BigDecimal getCompensation() {
        return compensation;
    }

    public void setCompensation(BigDecimal compensation) {
        this.compensation = compensation;
    }

    public String getRoleids() {
        return roleids;
    }

    public void setRoleids(String roleids) {
        this.roleids = roleids;
    }

    public String getLoginDateString() {
        return loginDateString;
    }

    public void setLoginDateString(String loginDateString) {
        this.loginDateString = loginDateString;
    }
}
