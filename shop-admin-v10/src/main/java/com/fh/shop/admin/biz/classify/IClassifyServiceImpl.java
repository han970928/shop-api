package com.fh.shop.admin.biz.classify;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.mapper.classify.IClassifyMapper;
import com.fh.shop.admin.po.classify.Classify;
import com.fh.shop.admin.vo.classify.ClassifyVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("classifyService")
public class IClassifyServiceImpl implements IClassifyService {
    @Autowired
    private IClassifyMapper classifyMapper;


    @Override
    public List<ClassifyVo> queryClassifyList() {
        List<Classify> classifyList = classifyMapper.queryClassifyList();
        //po 转 vo
        List<ClassifyVo> classifyVoList = duildVo(classifyList);
        return classifyVoList;
    }

    @Override
    public void add(Classify classify) {
        classifyMapper.add(classify);
    }

    @Override
    public void update(Classify classify) {
        classifyMapper.update(classify);
    }

    @Override
    public void delAll(List<Integer> list) {
        classifyMapper.delAll(list);
    }

    @Override
    public ServerResponse queryClassify(Long id) {
        QueryWrapper<Classify> queryWrapper = new QueryWrapper<>();
        // 通过前台传过来的Id ，去查找对应的子节点
        queryWrapper.eq("pid",id);
        List<Classify> classifyList = classifyMapper.selectList(queryWrapper);
        //po 转 vo
        List<ClassifyVo> classifyVoList = duildVo(classifyList);
        return ServerResponse.success(classifyVoList);
    }

    private List<ClassifyVo> duildVo(List<Classify> classifyList) {
        List<ClassifyVo> classifyVoList=new ArrayList<>();
        for (Classify classify : classifyList) {
            ClassifyVo vo=new ClassifyVo();
            vo.setId(classify.getId());
            vo.setName(classify.getClassifyName());
            vo.setpId(classify.getPid());
            classifyVoList.add(vo);
        }
        return classifyVoList;
    }
}
