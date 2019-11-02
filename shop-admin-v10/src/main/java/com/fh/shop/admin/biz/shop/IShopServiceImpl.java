package com.fh.shop.admin.biz.shop;

import com.fh.shop.admin.common.DateTable;
import com.fh.shop.admin.mapper.classify.IClassifyMapper;
import com.fh.shop.admin.mapper.shop.IShopMapper;
import com.fh.shop.admin.param.shop.ShopSearch;
import com.fh.shop.admin.po.classify.Classify;
import com.fh.shop.admin.po.shop.Shop;
import com.fh.shop.admin.utils.DateAndString;
import com.fh.shop.admin.utils.RedisUtil;
import com.fh.shop.admin.vo.shop.ShopVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("shopService")
public class IShopServiceImpl implements IShopService {
    @Autowired
    private IShopMapper shopMapper;

    @Override
    public DateTable queryShopList(ShopSearch shopSearch) {
        Integer count=shopMapper.queryShopCount(shopSearch);
        List<Shop> list=shopMapper.queryShopList(shopSearch);
        List<ShopVo> voList=new ArrayList<>();
        for (Shop shop : list) {
            ShopVo vo = getShopVo(shop);
            voList.add(vo);
        }
        DateTable dateTable=new DateTable(shopSearch.getDraw(),count,count,voList);
        return dateTable;
    }

    private ShopVo getShopVo(Shop shop) {
        ShopVo vo=new ShopVo();
        vo.setId(shop.getId());
        vo.setPrice(shop.getPrice().toString());
        vo.setShopName(shop.getShopName());
        vo.setProductiveTime(DateAndString.date2String(shop.getProductiveTime(),DateAndString.Y_M_D));
        vo.setIsHot(shop.getIsHot());
        vo.setStock(shop.getStock());
        vo.setIsShelf(shop.getIsShelf());
        vo.setBrandName(shop.getBrandName());
        vo.setBrandId(shop.getBrandId());
        vo.setImgPath(shop.getImgPath());
        vo.setClassifyName(shop.getClassifyName());
        return vo;
    }

    @Override
    public void add(Shop shop) {
        shopMapper.add(shop);
    }

    @Override
    public void del(Long id) {
        shopMapper.del(id);
    }

    @Override
    public ShopVo toupdate(Long id) {
        Shop shop = shopMapper.toupdate(id);
        shop.setClassifyName(shop.getClassifyName());
        ShopVo vo = getShopVo(shop);
        return vo;
    }

    @Override
    public void update(Shop shop) {
        shopMapper.update(shop);
    }

    @Override
    public List<Shop> findShopList(ShopSearch shopSearch) {
        return shopMapper.findShopList(shopSearch);
    }

    @Override
    public void updateShelf(Long id) {
        Shop shop = shopMapper.toupdate(id);
        Integer isShelf = shop.getIsShelf();
        if(isShelf==0){
            shop.setIsShelf(1);
        }else{
            shop.setIsShelf(0);
        }
        shopMapper.update(shop);
    }


}
