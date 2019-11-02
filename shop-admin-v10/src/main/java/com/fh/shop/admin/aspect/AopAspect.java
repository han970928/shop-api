package com.fh.shop.admin.aspect;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.admin.common.Logs;
import com.fh.shop.admin.common.SystemConstant;
import com.fh.shop.admin.mapper.log.ILogMapper;
import com.fh.shop.admin.po.log.Log;
import com.fh.shop.admin.po.user.UserPo;
import com.fh.shop.admin.utils.DistributedSession;
import com.fh.shop.admin.utils.KeyUtil;
import com.fh.shop.admin.utils.RedisUtil;
import com.fh.shop.admin.webcontext.WebContext;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;

public class AopAspect {
    private static final Logger LOGGER=LoggerFactory.getLogger(AopAspect.class);
    @Autowired
    private ILogMapper logMapper;

    public Object logAspect(ProceedingJoinPoint pjp) throws Exception {
        //获取类名
        String className = pjp.getTarget().getClass().getCanonicalName();
        //获取方法名
        String methodName = pjp.getSignature().getName();
        //实际执行的方法
        Object proceed =null;
        HttpServletRequest request = WebContext.getRequest();
        HttpServletResponse response = WebContext.getResponse();
        //UserPo user = (UserPo) request.getSession().getAttribute(SystemConstant.CURRENT_NAME);
        String sessionId = DistributedSession.getSession(request, response);
        String userJson = RedisUtil.get(KeyUtil.buildUserKey(sessionId));
        UserPo user = JSONObject.parseObject(userJson, UserPo.class);
        String userName = user.getUserName();
        String roleName = user.getRoleName();
        Log log=new Log();
        //获取参数信息
        Map<String, String[]> detail = request.getParameterMap();
        //迭代器循环参数信息
        Iterator<Map.Entry<String, String[]>> iterator = detail.entrySet().iterator();
        StringBuffer sb=new StringBuffer();
        while(iterator.hasNext()){
            Map.Entry<String, String[]> entry = iterator.next();
            sb.append("~").append(entry.getKey()+"-->"+StringUtils.join(entry.getValue(),","));
        }
        //日志信息
        String value="";
        MethodSignature methodSignature= (MethodSignature) pjp.getSignature();
        Method method = methodSignature.getMethod();
        if(method.isAnnotationPresent(Logs.class)){
            Logs annotation = method.getAnnotation(Logs.class);
             value = annotation.value();
        }
        //获取Ip地址
        String addr = request.getRemoteAddr();
        try {
             proceed = pjp.proceed();
             log.setUserName(userName);
             log.setRealName(roleName);
             log.setCurrDate(new Date());
             log.setInfo("IP为:"+addr+",用户名为"+userName+"执行了:"+className+"的"+methodName+"方法成功");
             log.setStatus(SystemConstant.LOG_SUCCESS);
             log.setErrorMsg("");
             log.setDetail(sb.toString());
             log.setContent(value);
             logMapper.addLog(log);
             LOGGER.info("IP为:"+addr+",用户"+userName+"执行了"+className+"的"+methodName+"方法成功");
        } catch (Throwable throwable) {
            log.setUserName(userName);
            log.setRealName(roleName);
            log.setCurrDate(new Date());
            log.setInfo("IP为:"+addr+",用户"+userName+"执行了:"+className+"的"+methodName+"方法失败");
            log.setStatus(SystemConstant.LOG_ERROR);
            log.setErrorMsg(throwable.getMessage());
            log.setDetail(sb.toString());
            log.setContent(value);
            logMapper.addLog(log);
            LOGGER.error("IP为:"+addr+",用户"+userName+"执行了"+className+"的"+methodName+"方法失败,错误信息为"+throwable.getMessage());
            throw  new RuntimeException(throwable);
        }
        return proceed;
    }
}
