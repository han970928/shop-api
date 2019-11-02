package com.fh.shop.admin.controller.role;

import com.fh.shop.admin.biz.role.IRoleService;
import com.fh.shop.admin.common.DateTable;
import com.fh.shop.admin.common.Logs;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.role.RoleSearch;
import com.fh.shop.admin.po.role.Role;
import com.fh.shop.admin.vo.role.RoleVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/role")
public class RoleController {
    @Resource(name="roleService")
    private IRoleService roleService;

    @RequestMapping("/toList")
    public String toList(){
        return "/role/list";
    }
    @RequestMapping("/queryRoleList")
    @ResponseBody
    public ServerResponse queryRoleList(){
            List<Role> roleList = roleService.queryRoleList();
            return ServerResponse.success(roleList);
    }
    @RequestMapping("/queryRole")
    @ResponseBody
    public DateTable queryRole(RoleSearch roleSearch){
        DateTable  dateTable=roleService.queryRole(roleSearch);
        return dateTable;
    }
    @RequestMapping("/add")
    @ResponseBody
    @Logs("用户增加角色")
    public ServerResponse add(Role role, @RequestParam("list[]") List<Long> list){
            roleService.add(role,list);
            return  ServerResponse.success();
    }
    @RequestMapping("/del")
    @ResponseBody
    @Logs("用户删除角色")
    public ServerResponse del(Long id){
            roleService.del(id);
           return  ServerResponse.success();
    }
    @RequestMapping("/toupdate")
    @ResponseBody
    public ServerResponse toupdate(Long id){
            RoleVo role=roleService.toupdate(id);
           return ServerResponse.success(role);
    }
    @RequestMapping("/update")
    @ResponseBody
    @Logs("用户修改角色")
    public ServerResponse update(Role role,@RequestParam("list[]") List<Long> list){
            roleService.update(role,list);
            return ServerResponse.success();
    }
}
