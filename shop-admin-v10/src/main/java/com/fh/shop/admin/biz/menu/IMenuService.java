package com.fh.shop.admin.biz.menu;

import com.fh.shop.admin.po.menu.Menu;
import com.fh.shop.admin.vo.menu.MenuVo;

import java.util.List;

public interface IMenuService {
    List<MenuVo> queryMenuList();
    void  add(Menu menu);

    void update(Menu menu);

    void delAll(List<Integer> list);

    List<Menu> queryMenuListByUserId(Long id);

    List<Menu> findMenuListAll();

    List<Menu> queryUserMenuList(Long id);
}

