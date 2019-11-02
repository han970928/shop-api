package com.fh.shop.admin.controller.brand;

import com.fh.shop.admin.biz.brand.IBrandService;
import com.fh.shop.admin.common.DateTable;
import com.fh.shop.admin.common.Logs;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.brand.BrandSearch;
import com.fh.shop.admin.po.brand.Brand;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/brand")
public class BrandController {
    @Resource(name="brandService")
    private IBrandService brandService;

    @RequestMapping("/toList")
    public String toList(){
        return "/brand/list";
    }

    @RequestMapping("/queryBrandList")
    @ResponseBody
    public DateTable queryBrandList(BrandSearch brandSearch){
        DateTable result=brandService.queryBrandList(brandSearch);
        return result;
    }
    @RequestMapping("/add")
    @ResponseBody
    @Logs("用户增加品牌")
    public ServerResponse add(Brand brand){
            brandService.add(brand);
            return ServerResponse.success();
    }
    @RequestMapping("/del")
    @ResponseBody
    @Logs("用户删除品牌")
    public ServerResponse del(Long id){
            brandService.del(id);
            return ServerResponse.success();
    }
    @RequestMapping("/toupdate")
    @ResponseBody
    public ServerResponse toupdate(Long id){
            Brand  brand=brandService.toupdate(id);
            return ServerResponse.success(brand);
    }
    @RequestMapping("/update")
    @ResponseBody
    @Logs("用户修改品牌")
    public ServerResponse update(Brand brand,String formerPhoto){
            brandService.update(brand,formerPhoto);
            return ServerResponse.success();
    }

    @RequestMapping("/queryBrand")
    @ResponseBody
    public ServerResponse queryBrand(){
        return brandService.queryBrand();
    }

    @RequestMapping("/updatePopular")
    @ResponseBody
    public ServerResponse updatePopular(Long id,Integer popular){
        /*修改热销状态*/
        return brandService.updatePopular(id,popular);
    }

    @RequestMapping("/updateSort")
    @ResponseBody
    public ServerResponse updateSort(Long id,Integer sort){
        /*排序*/
        return brandService.updateSort(id,sort);
    }

}
