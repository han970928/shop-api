package com.fh.shop.admin.mapper.menu;

import com.fh.shop.admin.po.menu.Menu;

import java.util.List;

public interface IMenuMapper {
    List<Menu> queryMenuList();
    void  add(Menu menu);

    void update(Menu menu);

    void delAll(List<Integer> list);

    List<Menu> queryMenuListByUserId(Long id);

    List<Menu> queryUserMenuList(Long id);
}
