package com.fh.shop.admin.mapper.vip;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.shop.admin.param.vip.VipSearch;
import com.fh.shop.admin.po.vip.Vip;

import java.util.List;

public interface IVipMapper extends BaseMapper<Vip> {

    Integer queryCount(VipSearch vipSearch);

    List<Vip> queryList(VipSearch vipSearch);

}
