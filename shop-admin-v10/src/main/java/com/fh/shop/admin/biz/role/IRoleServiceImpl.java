package com.fh.shop.admin.biz.role;

import com.fh.shop.admin.common.DateTable;
import com.fh.shop.admin.mapper.role.IRoleMapper;
import com.fh.shop.admin.param.role.RoleSearch;
import com.fh.shop.admin.po.role.Role;
import com.fh.shop.admin.po.role.RoleMenu;
import com.fh.shop.admin.vo.role.RoleVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("roleService")
public class IRoleServiceImpl implements IRoleService {
    @Autowired
    private IRoleMapper roleMapper;
    public List<Role> queryRoleList(){
        return roleMapper.queryRoleList();
    }


    @Override
    public DateTable queryRole(RoleSearch roleSearch) {
        int count = roleMapper.queryRoleCount(roleSearch);
        List<Role> roleList = roleMapper.queryRole(roleSearch);
        DateTable dateTable=new DateTable(roleSearch.getDraw(),count,count,roleList);
        return dateTable;
    }

    @Override
    public void add(Role role,List<Long> list) {
        roleMapper.add(role);
        addRoleMenu(role, list);
    }

    private void addRoleMenu(Role role, List<Long> list) {
        Long roleId = role.getId();
        List<RoleMenu> roleList=new ArrayList<>();
        for (Long aLong : list) {
            RoleMenu rm=new RoleMenu();
            rm.setRoleId(roleId);
            rm.setMenuId(aLong);
            roleList.add(rm);
        }
        roleMapper.addRoleMenu(roleList);
    }

    @Override
    public void del(Long id) {
        roleMapper.del(id);
        roleMapper.deleteRoleMenu(id);
    }

    @Override
    public RoleVo toupdate(Long id) {
        Role toupdate = roleMapper.toupdate(id);
        List<Long> roleMenuList=roleMapper.queryRoleMenuList(id);
        RoleVo vo=new RoleVo();
        vo.setRoleStrIds(roleMenuList);
        vo.setRoleName(toupdate.getRoleName());
        return vo;
    }

    @Override
    public void update(Role role,List<Long> list) {
        roleMapper.update(role);
        Long roleId = role.getId();
        if(list.indexOf(list)==-1){
            //先删除中间表角色拥有的权限，
            roleMapper.deleteRoleMenu(roleId);
            //重新增加/赋值
        }
        addRoleMenu(role, list);
    }
}
