package com.fh.shop.admin.controller.menu;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.admin.biz.menu.IMenuService;
import com.fh.shop.admin.common.Logs;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.common.SystemConstant;
import com.fh.shop.admin.po.menu.Menu;
import com.fh.shop.admin.utils.DistributedSession;
import com.fh.shop.admin.utils.KeyUtil;
import com.fh.shop.admin.utils.RedisUtil;
import com.fh.shop.admin.vo.menu.MenuVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("/menu")
public class MenuController {
    @Resource(name="menuService")
    private IMenuService menuService;
    @Autowired
    private HttpServletRequest request;

    @Resource
    private HttpServletResponse response;


    @RequestMapping("/toList")
    public String toList(){
        return "/menu/list";
    }

    @RequestMapping("/queryMenuListByUserId")
    @ResponseBody
    public ServerResponse queryMenuListByUserId(){
           // List<Menu> menuList = (List<Menu>) request.getSession().getAttribute(SystemConstant.MENU_LIST_BY_USER);
            String sessionId = DistributedSession.getSession(request, response);
            String menuListJson = RedisUtil.get(KeyUtil.buildUserMenuListKey(sessionId));
            List<Menu> menuList = JSONObject.parseArray(menuListJson, Menu.class);
            return ServerResponse.success(menuList);
    }

    @RequestMapping("/queryMenuList")
    @ResponseBody
    public ServerResponse queryMenuList(){
            List<MenuVo> menuList = menuService.queryMenuList();
            return ServerResponse.success(menuList);
    }
    @RequestMapping("/add")
    @ResponseBody
    @Logs("用户增加菜单")
    public ServerResponse add(Menu menu){
            menuService.add(menu);
            return ServerResponse.success(menu.getId());
    }
    @RequestMapping("/update")
    @ResponseBody
    @Logs("用户修改菜单")
    public ServerResponse update(Menu menu){
            menuService.update(menu);
           return  ServerResponse.success();
    }
    @RequestMapping("/delAll")
    @ResponseBody
    @Logs("用户删除菜单")
    public ServerResponse delAll(@RequestParam("list[]") List<Integer> list){
            menuService.delAll(list);
            return ServerResponse.success();
    }
}
