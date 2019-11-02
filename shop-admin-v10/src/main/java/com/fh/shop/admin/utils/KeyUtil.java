package com.fh.shop.admin.utils;

public class KeyUtil {

    public static  String buildCodeKey(String data){
        return "code:"+data;
    }
    public static  String buildUserKey(String data){
        return "user:"+data;
    }
    public static  String buildMenuKey(String data){
        return "menuList:"+data;
    }

    public static String buildMenuListAllKey(String data) {
        return  "menuListAll:"+data;
    }

    public static String buildUserMenuListKey(String data) {
        return  "userMenuList:"+data;
    }
}
