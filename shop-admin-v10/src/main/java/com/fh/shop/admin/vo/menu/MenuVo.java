package com.fh.shop.admin.vo.menu;

import java.io.Serializable;

public class MenuVo implements Serializable {
    private Long id;
    private String name;
    private Long  pId;
    private Long  menuType;
    private String menuUrl;

    public Long getMenuType() {
        return menuType;
    }

    public void setMenuType(Long menuType) {
        this.menuType = menuType;
    }

    public String getMenuUrl() {
        return menuUrl;
    }

    public void setMenuUrl(String menuUrl) {
        this.menuUrl = menuUrl;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getpId() {
        return pId;
    }

    public void setpId(Long pId) {
        this.pId = pId;
    }
}
