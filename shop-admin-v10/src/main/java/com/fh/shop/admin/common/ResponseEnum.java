package com.fh.shop.admin.common;

public enum ResponseEnum {
    USERNAME_IS_ERROR(1001,"账户不存在"),
    PASSWORD_ID_ERROR(1002,"密码错误"),
    USER_ID_ERROR(1003,"账户已锁定"),
    USERNAME_IS_SUO(1004,"账户已锁定"),
    USER_PASSWORD_NULL(1005,"密码不能为空"),
    USER_PASSWORD_NEW_CONFIRM_NO(1006,"两次输入密码不一致"),
    USER_OLDPASSWORD_ERROR(1007,"原密码输入错误"),
    USEREMAIL_IS_ERROR(1008,"邮箱不存在"),
    IMG_ERROR(1009,"验证码错误"),
    USERNAME_PASSWORD_IS_NULL(1000,"账户名称,验证码或密码为空！");
    private int code;
    private String msg;

    private  ResponseEnum (int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}
