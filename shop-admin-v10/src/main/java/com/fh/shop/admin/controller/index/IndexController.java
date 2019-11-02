package com.fh.shop.admin.controller.index;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/index")
public class IndexController {
    @RequestMapping("/index")
    public String index(){
        return "/index";
    }

    @RequestMapping("/forgetPassword")
    public String forgetPassword(){
        return "/user/forgetPassword";
    }
}
