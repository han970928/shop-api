package com.fh.shop.admin.mapper.brand;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.shop.admin.param.brand.BrandSearch;
import com.fh.shop.admin.po.brand.Brand;

import java.util.List;

public interface IBrandMapper extends BaseMapper<Brand> {

    List<Brand> queryBrandList(BrandSearch brandSearch);

    Integer queryBrandCount(BrandSearch brandSearch);

    void add(Brand brand);

    void del(Long id);

    Brand toupdate(Long id);

    void update(Brand brand);

    List<Brand> queryBrand();

}
