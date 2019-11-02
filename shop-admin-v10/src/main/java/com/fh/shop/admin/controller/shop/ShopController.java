package com.fh.shop.admin.controller.shop;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.admin.biz.shop.IShopService;
import com.fh.shop.admin.common.DateTable;
import com.fh.shop.admin.common.Logs;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.shop.ShopSearch;
import com.fh.shop.admin.po.shop.Shop;
import com.fh.shop.admin.utils.DateAndString;
import com.fh.shop.admin.utils.ExcelUtil;
import com.fh.shop.admin.utils.FileUtil;
import com.fh.shop.admin.vo.shop.ShopVo;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/shop")
public class ShopController {
    @Resource(name="shopService")
    private IShopService shopService;

    @RequestMapping("/toList")
    public String toList(){
        return "/shop/list";
    }

    @RequestMapping("/queryShopList")
    @ResponseBody
    public DateTable queryShopList(ShopSearch shopSearch){
        DateTable result=shopService.queryShopList(shopSearch);
        return result;
    }

    @RequestMapping("/add")
    @ResponseBody
    @Logs("用户增加商品")
    public ServerResponse add(Shop shop){
            shopService.add(shop);
            return ServerResponse.success();
    }

    @RequestMapping("/del")
    @ResponseBody
    @Logs("用户删除商品")
    public ServerResponse del(Long id){
            shopService.del(id);
            return  ServerResponse.success();
    }

    @RequestMapping("/toupdate")
    @ResponseBody
    public ServerResponse toupdate(Long id){
            ShopVo shop=shopService.toupdate(id);
            return ServerResponse.success(shop);
    }

    @RequestMapping("/update")
    @ResponseBody
    @Logs("用户修改商品")
    public ServerResponse update(Shop shop){
            shopService.update(shop);
            return ServerResponse.success();
    }

    @RequestMapping("/updateShelf")
    @ResponseBody
    @Logs("用户修改商品上架下架")
    public ServerResponse updateShelf(Long id){
            shopService.updateShelf(id);
            return ServerResponse.success();
    }

    @RequestMapping("/downExcel")
    @Logs("用户导出downExcel")
    public void downExcel(ShopSearch shopSearch, HttpServletResponse response){
        //查询数据
        List<Shop> shopList=shopService.findShopList(shopSearch);
        //创建对象
        String[] heads={"商品名称","商品价格","出厂日期","商品库存","热销状态","上架状态","商品分类","商品品牌"};
        String[] proper={"shopName","price","productiveTime","stock","isHot","isShelf","classifyName","brandName",};
        XSSFWorkbook xssfWorkbook = ExcelUtil.downExcel("商品", heads, shopList, proper, Shop.class);
        //进行下载
        FileUtil.xlsDownloadFile(response,xssfWorkbook);
    }



}
