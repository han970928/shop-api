package com.fh.shop.admin.interceptor;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.admin.common.SystemConstant;
import com.fh.shop.admin.po.menu.Menu;
import com.fh.shop.admin.utils.DistributedSession;
import com.fh.shop.admin.utils.KeyUtil;
import com.fh.shop.admin.utils.RedisUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MyInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        //地址栏路径
        String requestURI = request.getRequestURI();
        // 是否有权限
        boolean ispermission=false;
        // 所有菜单列表
       // List<Menu> menuListAll = (List<Menu>) request.getSession().getAttribute(SystemConstant.MENU_ALL);
        String sessionId = DistributedSession.getSession(request, response);
        String menuListAllJson = RedisUtil.get(KeyUtil.buildUserMenuListKey(sessionId));
        List<Menu> menuListAll = JSONObject.parseArray(menuListAllJson, Menu.class);
        for (Menu menu : menuListAll) {
            //判断是否是此账号拥有的菜单资源
            if(StringUtils.isNotEmpty(menu.getMenuUrl()) && requestURI.contains(menu.getMenuUrl())){
                // 是这个账号拥有的菜单资源
                ispermission=true;
                break;
            }
        }
        // 不是 ,代表是公共的菜单资源
        if(!ispermission){
            return true;
        }
        boolean  flag=false;
        //当前用户所拥有的所有菜单
        //List<Menu> userMenuList = (List<Menu>)request.getSession().getAttribute(SystemConstant.USER_MENU_LIST);
        String userMenuListJson = RedisUtil.get(KeyUtil.buildMenuListAllKey(sessionId));
        List<Menu> userMenuList = JSONObject.parseArray(userMenuListJson, Menu.class);
        for (Menu menu : userMenuList) {
            // 判断是否是非法入侵
            if(StringUtils.isNotEmpty(menu.getMenuUrl()) && requestURI.contains(menu.getMenuUrl())){
                flag=true;
                break;
            }
        }
        // 此账号没有权限跳转的地方
        if(flag==false){
            //判断哪些是此账号拥有的按钮
            //判断是否是ajax 请求
            String header = request.getHeader("X-Requested-With");
            if(StringUtils.isNotEmpty(header) && header.equals("XMLHttpRequest")){
                Map result=new HashMap();
                result.put("code","-100");
                result.put("msg","你没有此权限");
                // 转换成json 格式的字符串
                String toJSONString = JSONObject.toJSONString(result);
                outJson(toJSONString,response);
            }else {
                response.sendRedirect("/error.jsp");
            }
        }
        return flag;
    }

    private void outJson(String json,HttpServletResponse response){
        PrintWriter writer =null;
        response.setContentType("application/json;charset=utf-8");
        try {
             writer = response.getWriter();
             writer.write(json);
             writer.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            if(writer!=null){
                writer.close();
                writer =null;
            }
        }
    }
}
