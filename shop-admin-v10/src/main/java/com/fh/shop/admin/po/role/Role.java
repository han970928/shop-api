package com.fh.shop.admin.po.role;

import com.fh.shop.admin.common.Page;

import java.io.Serializable;

public class Role extends Page implements Serializable {
    private Long   id;
    private String roleName;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
}
