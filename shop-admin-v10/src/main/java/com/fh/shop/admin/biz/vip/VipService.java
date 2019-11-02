package com.fh.shop.admin.biz.vip;

import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.vip.VipSearch;

public interface VipService {
    ServerResponse querySearch(VipSearch vipSearch);
}
