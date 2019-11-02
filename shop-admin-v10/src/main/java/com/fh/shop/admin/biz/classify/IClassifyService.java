package com.fh.shop.admin.biz.classify;


import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.po.classify.Classify;
import com.fh.shop.admin.vo.classify.ClassifyVo;

import java.util.List;

public interface IClassifyService {
    List<ClassifyVo> queryClassifyList();

    void add(Classify classify);

    void update(Classify classify);

    void delAll(List<Integer> list);

    ServerResponse queryClassify(Long id);
}
