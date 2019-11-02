package com.fh.shop.admin.biz.role;

import com.fh.shop.admin.common.DateTable;
import com.fh.shop.admin.param.role.RoleSearch;
import com.fh.shop.admin.po.role.Role;
import com.fh.shop.admin.vo.role.RoleVo;

import java.util.List;

public interface IRoleService {
    public List<Role> queryRoleList();

    DateTable queryRole(RoleSearch roleSearch);

    void add(Role role,List<Long> list);

    void del(Long id);

    RoleVo toupdate(Long id);

    void update(Role role,List<Long> list);

}
