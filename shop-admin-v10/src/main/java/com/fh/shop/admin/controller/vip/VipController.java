package com.fh.shop.admin.controller.vip;

import com.fh.shop.admin.biz.vip.VipService;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.vip.VipSearch;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;


@Controller
@RequestMapping("/vip")
public class VipController {

    @Resource(name="vipService")
    private VipService vipService;

    @RequestMapping("/tolist")
    public String tolist(){
        return "/vip/list";
    }


    @RequestMapping("/querySearch")
    @ResponseBody
    public ServerResponse querySearch(VipSearch vipSearch){
        return vipService.querySearch(vipSearch);
    }

}
