package com.fh.shop.admin.biz.menu;

import com.fh.shop.admin.mapper.menu.IMenuMapper;
import com.fh.shop.admin.po.menu.Menu;
import com.fh.shop.admin.vo.menu.MenuVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("menuService")
public class IMenuServiceImpl implements IMenuService {
    @Autowired
    private IMenuMapper menuMapper;

    @Override
    public List<MenuVo> queryMenuList() {
        List<Menu> menuList = menuMapper.queryMenuList();
        List<MenuVo>  menuVoList=new ArrayList<>();
        for (Menu menu : menuList) {
            MenuVo vo=new MenuVo();
            vo.setId(menu.getId());
            vo.setName(menu.getMenuName());
            vo.setpId(menu.getFatherId());
            vo.setMenuType(menu.getMenuType());
            vo.setMenuUrl(menu.getMenuUrl());
            menuVoList.add(vo);
        }
        return menuVoList;
    }

    @Override
    public void add(Menu menu) {
        menuMapper.add(menu);
    }

    @Override
    public void update(Menu menu) {
        menuMapper.update(menu);
    }

    @Override
    public void delAll(List<Integer> list) {
        menuMapper.delAll(list);
    }

    @Override
    public List<Menu> queryMenuListByUserId(Long id) {
        return menuMapper.queryMenuListByUserId(id);
    }

    @Override
    public List<Menu> findMenuListAll() {
        List<Menu> list = menuMapper.queryMenuList();
        return list;
    }

    @Override
    public List<Menu> queryUserMenuList(Long id) {
        return menuMapper.queryUserMenuList(id);
    }
}
