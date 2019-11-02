package com.fh.shop.admin.mapper.shop;

import com.fh.shop.admin.param.shop.ShopSearch;
import com.fh.shop.admin.po.shop.Shop;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IShopMapper {
    List<Shop> queryShopList(ShopSearch shopSearch);

    Integer queryShopCount(ShopSearch shopSearch);

    void add(Shop shop);

    void del(Long id);

    Shop toupdate(Long id);

    void update(Shop shop);

    List<Shop> findShopList(ShopSearch shopSearch);

}
