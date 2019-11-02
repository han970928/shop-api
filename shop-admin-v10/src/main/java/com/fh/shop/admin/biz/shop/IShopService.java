package com.fh.shop.admin.biz.shop;

import com.fh.shop.admin.common.DateTable;
import com.fh.shop.admin.param.shop.ShopSearch;
import com.fh.shop.admin.po.shop.Shop;
import com.fh.shop.admin.vo.shop.ShopVo;

import java.util.List;

public interface IShopService {
    DateTable queryShopList(ShopSearch shopSearch);

    void add(Shop shop);

    void del(Long id);

    ShopVo toupdate(Long id);

    void update(Shop shop);

    List<Shop> findShopList(ShopSearch shopSearch);

    void updateShelf(Long id);
}
