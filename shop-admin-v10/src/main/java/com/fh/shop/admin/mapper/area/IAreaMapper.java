package com.fh.shop.admin.mapper.area;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.shop.admin.po.area.Area;

import java.util.List;

public interface IAreaMapper extends BaseMapper<Area> {
    List<Area> queryAreaList();
    void add(Area area);

    void update(Area area);

    void delAll(List<Integer> list);
}
