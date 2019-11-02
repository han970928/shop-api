package com.fh.shop.admin.mapper.role;

import com.fh.shop.admin.param.role.RoleSearch;
import com.fh.shop.admin.po.role.Role;
import com.fh.shop.admin.po.role.RoleMenu;
import com.fh.shop.admin.vo.role.RoleVo;

import java.util.List;

public interface IRoleMapper {
    public List<Role> queryRoleList();

    int queryRoleCount(RoleSearch roleSearch);

    List<Role> queryRole(RoleSearch roleSearch);

    void add(Role role);

    void del(Long id);

    Role toupdate(Long id);

    void update(Role role);

    void addRoleMenu(List<RoleMenu> roleList);

    List<Long> queryRoleMenuList(Long id);

    void deleteRoleMenu(Long roleId);
}
