package com.fh.shop.admin.webcontext;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class WebContextFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
       try{
           //将当前请求的request 放入Filter
           WebContext.setRequest((HttpServletRequest) request);
           WebContext.setResponse((HttpServletResponse) response);
           //固定的
           chain.doFilter(request,response);
       }finally {
           //释放资源
           WebContext.remove();
       }

    }

    @Override
    public void destroy() {

    }
}
