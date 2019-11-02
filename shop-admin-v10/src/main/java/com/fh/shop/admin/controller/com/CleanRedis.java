package com.fh.shop.admin.controller.com;

import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.utils.RedisUtil;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/clean")
public class CleanRedis {

    @RequestMapping("/cleanCache")
    public ServerResponse cleanCache(){
        RedisUtil.del("shopList");
        return ServerResponse.success();
    }
}
