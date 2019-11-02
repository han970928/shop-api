package com.fh.shop.admin.biz.vip;

import com.fh.shop.admin.common.DateTable;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.mapper.vip.IVipMapper;
import com.fh.shop.admin.param.vip.VipSearch;
import com.fh.shop.admin.po.vip.Vip;
import com.fh.shop.admin.utils.DateAndString;
import com.fh.shop.admin.vo.vip.VipVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


@Service("vipService")
public class VipServiceImpl implements VipService {
    @Autowired
    private IVipMapper vipMapper;

    @Override
    public ServerResponse querySearch(VipSearch vipSearch) {
        Integer count=vipMapper.queryCount(vipSearch);
        List<Vip> list=vipMapper.queryList(vipSearch);
        List<VipVo> voList=new ArrayList<>();
        for (Vip vip : list) {
            VipVo vipVo=new VipVo();
            vipVo.setId(vip.getId());
            vipVo.setAddress(vip.getAddress());
            vipVo.setAreaName(vip.getAreaName());
            vipVo.setBirthday(DateAndString.date2String(vip.getBirthday(),DateAndString.Y_M_D));
            vipVo.setEmail(vip.getEmail());
            vipVo.setPhone(vip.getPhone());
            vipVo.setRealName(vip.getRealName());
            vipVo.setUserName(vip.getUserName());
            voList.add(vipVo);
        }
        DateTable dateTable=new DateTable(vipSearch.getDraw(),count,count,voList);
        return ServerResponse.success(dateTable);
    }
}
