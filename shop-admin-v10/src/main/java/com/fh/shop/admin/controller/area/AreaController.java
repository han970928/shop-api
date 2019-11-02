package com.fh.shop.admin.controller.area;

import com.fh.shop.admin.biz.area.IAreaService;
import com.fh.shop.admin.common.Logs;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.controller.shop.ShopController;
import com.fh.shop.admin.po.area.Area;
import com.fh.shop.admin.vo.area.AreaVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/area")
public class AreaController {
    @Resource(name="areaService")
    private IAreaService areaService;

    @RequestMapping("/toList")
    public String toList(){
        return "/area/list";
    }
    @RequestMapping("/queryAreaList")
    @ResponseBody
    public ServerResponse queryAreaList(){
            List<AreaVo>   areaList = areaService.queryAreaList();
           return ServerResponse.success(areaList);
    }
    @RequestMapping("/add")
    @ResponseBody
    @Logs("用户增加地区")
    public ServerResponse add(Area area){
            areaService.add(area);
            return ServerResponse.success(area.getId());
    }
    @RequestMapping("/update")
    @ResponseBody
    @Logs("用户修改地区")
    public ServerResponse update(Area area){
            areaService.update(area);
            return ServerResponse.success();
    }
    @RequestMapping("/delAll")
    @ResponseBody
    @Logs("用户删除地区")
    public ServerResponse delAll(@RequestParam("list[]") List<Integer> list){
            areaService.delAll(list);
            return ServerResponse.success();
    }
    @RequestMapping("/queryArea")
    @ResponseBody
    public ServerResponse queryArea(Long id){
            return areaService.queryArea(id);
    }
}
