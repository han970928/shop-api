package com.fh.shop.admin.biz.area;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.mapper.area.IAreaMapper;
import com.fh.shop.admin.po.area.Area;
import com.fh.shop.admin.vo.area.AreaVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("areaService")
public class IAreaServiceImpl implements IAreaService {
    @Autowired
    private IAreaMapper areaMapper;
    public List<AreaVo> queryAreaList(){
        List<Area> areaList = areaMapper.queryAreaList();
        List<AreaVo> areaVo=new ArrayList<>();
        for (Area area : areaList) {
            AreaVo vo=new AreaVo();
            vo.setId(area.getId());
            vo.setName(area.getAreaName());
            vo.setpId(area.getPid());
            areaVo.add(vo);
        }
        return areaVo;
    }
    public void add(Area area){
        areaMapper.add(area);
    }

    @Override
    public void update(Area area) {
        areaMapper.update(area);
    }

    @Override
    public void delAll(List<Integer> list) {
        areaMapper.delAll(list);
    }

    @Override
    public ServerResponse queryArea(Long id) {
        QueryWrapper<Area> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("pid",id);
        List<Area> areas = areaMapper.selectList(queryWrapper);
        return ServerResponse.success(areas);
    }
}
