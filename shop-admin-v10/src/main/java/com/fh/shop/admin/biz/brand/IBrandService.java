package com.fh.shop.admin.biz.brand;

import com.fh.shop.admin.common.DateTable;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.brand.BrandSearch;
import com.fh.shop.admin.po.brand.Brand;

import java.util.List;

public interface IBrandService {
    DateTable queryBrandList(BrandSearch brandSearch);

    void add(Brand brand);

    void del(Long id);

    Brand toupdate(Long id);

    void update(Brand brand,String formerPhoto);

    ServerResponse queryBrand();

    ServerResponse updatePopular(Long id, Integer popular);

    ServerResponse updateSort(Long id,Integer sort);
}

