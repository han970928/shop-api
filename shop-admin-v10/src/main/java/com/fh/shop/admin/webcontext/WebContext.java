package com.fh.shop.admin.webcontext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WebContext {
    private static  final  ThreadLocal<HttpServletRequest>   requestThreadLocal=new ThreadLocal();
    private static  final  ThreadLocal<HttpServletResponse>  responseThreadLocal=new ThreadLocal();

    public static void setRequest(HttpServletRequest request){
        requestThreadLocal.set(request);
    }
    public static HttpServletRequest getRequest(){
        return requestThreadLocal.get();
    }
    public static void setResponse(HttpServletResponse response){
        responseThreadLocal.set(response);
    }
    public static HttpServletResponse getResponse(){
        return responseThreadLocal.get();
    }
    public static void remove(){
        //释放资源
        requestThreadLocal.remove();
        responseThreadLocal.remove();
    }
}
