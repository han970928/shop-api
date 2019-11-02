package com.fh.shop.admin.biz.area;

import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.po.area.Area;
import com.fh.shop.admin.vo.area.AreaVo;

import java.util.List;

public interface IAreaService {
    List<AreaVo> queryAreaList();
    void add(Area area);

    void update(Area area);

    void delAll(List<Integer> list);

    ServerResponse queryArea(Long id);
}
