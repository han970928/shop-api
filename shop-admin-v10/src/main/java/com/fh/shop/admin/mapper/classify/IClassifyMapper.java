package com.fh.shop.admin.mapper.classify;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.shop.admin.po.classify.Classify;

import java.util.List;

public interface IClassifyMapper extends BaseMapper<Classify> {

    List<Classify> queryClassifyList();

    void add(Classify classify);

    void update(Classify classify);

    void delAll(List<Integer> list);
}
