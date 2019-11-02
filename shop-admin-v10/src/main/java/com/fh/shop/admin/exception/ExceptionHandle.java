package com.fh.shop.admin.exception;

import com.fh.shop.admin.common.ServerResponse;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice
public class ExceptionHandle {

    @ExceptionHandler(Exception.class)
    @ResponseBody
    private ServerResponse exceptionHandle(Exception e){
        e.printStackTrace();
        return ServerResponse.error();
    }
}
