package com.fh.shop.admin.interceptor;

import com.fh.shop.admin.common.SystemConstant;
import com.fh.shop.admin.utils.DistributedSession;
import com.fh.shop.admin.utils.KeyUtil;
import com.fh.shop.admin.utils.RedisUtil;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyInterceptorClass extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        // Object user = request.getSession().getAttribute(SystemConstant.CURRENT_NAME);
        String sessionId = DistributedSession.getSession(request, response);
        String user = RedisUtil.get(KeyUtil.buildUserKey(sessionId));
        if(user!=null){
            RedisUtil.setSeconds(KeyUtil.buildUserKey(sessionId),SystemConstant.USER_EXPIRE);
            RedisUtil.setSeconds(KeyUtil.buildMenuKey(sessionId),SystemConstant.USER_EXPIRE);
            RedisUtil.setSeconds(KeyUtil.buildMenuListAllKey(sessionId),SystemConstant.USER_EXPIRE);
            RedisUtil.setSeconds(KeyUtil.buildUserMenuListKey(sessionId),SystemConstant.USER_EXPIRE);
            return true;
        }else{
            response.sendRedirect("/");
            return false;
        }
    }

}
