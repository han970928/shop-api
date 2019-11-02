package com.fh.shop.admin.vo.role;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class RoleVo implements Serializable {
    private String roleName;
    private List<Long>  roleStrIds=new ArrayList<>();

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public List<Long> getRoleStrIds() {
        return roleStrIds;
    }

    public void setRoleStrIds(List<Long> roleStrIds) {
        this.roleStrIds = roleStrIds;
    }
}
