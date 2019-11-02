package com.fh.shop.admin.biz.brand;

import com.alibaba.fastjson.JSONObject;
import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.fh.shop.admin.common.DateTable;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.mapper.brand.IBrandMapper;
import com.fh.shop.admin.param.brand.BrandSearch;
import com.fh.shop.admin.po.brand.Brand;
import com.fh.shop.admin.utils.RedisUtil;
import com.fh.shop.admin.vo.brand.BrandVo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("brandService")
public class IBrandServiceImpl implements IBrandService {
    @Autowired
    private IBrandMapper brandMapper;

    @Override
    public DateTable queryBrandList(BrandSearch brandSearch) {
        List<Brand> list=brandMapper.queryBrandList(brandSearch);
        List<BrandVo> brandVoList=new ArrayList<>();
        for (Brand brands : list) {
            BrandVo vo = getBrandVo(brands);
            brandVoList.add(vo);
        }
        Integer count=brandMapper.queryBrandCount(brandSearch);
        DateTable dateTable = new DateTable(brandSearch.getDraw(), count, count, brandVoList);
        return dateTable;
    }

    @Override
    public void add(Brand brand) {
        RedisUtil.del("brandList");
        RedisUtil.del("shopList");
        brandMapper.add(brand);
    }

    @Override
    public void del(Long id) {
        brandMapper.del(id);
        RedisUtil.del("brandList");
        RedisUtil.del("shopList");
    }

    @Override
    public Brand toupdate(Long id) {
        return brandMapper.toupdate(id);
    }


    public void update(Brand brand,String formerPhoto) {
        //判断上传了新文件，则删除旧文件
        if (!StringUtils.equals(brand.getImgPath(),formerPhoto)&&formerPhoto!=""){
            // Endpoint以杭州为例，其它Region请按实际情况填写。
            String endpoint = "oss-cn-beijing.aliyuncs.com";
            // 阿里云主账号AccessKey
            String accessKeyId = "LTAI4Fr9c4F4cUu1HaKsybLh";
            String accessKeySecret = "QiL9IRUepflQawxVSjNiSyHK1Rb88J";
            String bucketName = "lishihui";
            //截取名字
            String str1=formerPhoto.substring(0, formerPhoto.indexOf(".com"));
            String objectName=formerPhoto.substring(str1.length()+5, formerPhoto.length());
            //String objectName = formerPhoto.lastIndexOf("\.com");
            // 创建OSSClient实例。
            OSS ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);
            // 删除文件。
            ossClient.deleteObject(bucketName, objectName);
            // 关闭OSSClient。
            ossClient.shutdown();
        }
        RedisUtil.del("brandList");
        RedisUtil.del("shopList");
        brandMapper.update(brand);
    }

    @Override
    public ServerResponse queryBrand() {
        //先从缓存中拿取到值
        String brandListRedis = RedisUtil.get("brandList");
        //判断缓存中是否有值
        if(StringUtils.isEmpty(brandListRedis)){
            //没有，则从数据库里面找
            List<Brand> brandList = brandMapper.queryBrand();
            List<BrandVo> brandVoList=new ArrayList<>();
            for (Brand brand : brandList) {
                BrandVo vo = getBrandVo(brand);
                brandVoList.add(vo);
            }
            //将java 对象转换为 String 类型的，存入到缓存服务器中
            String toJSONString = JSONObject.toJSONString(brandVoList);
            RedisUtil.set("brandList",toJSONString);
            return ServerResponse.success(brandVoList);
        }else{
            // 有直接返回
            List<Brand> brandListVo = JSONObject.parseArray(brandListRedis, Brand.class);
            return ServerResponse.success(brandListVo);
        }
    }

    @Override
    public ServerResponse updatePopular(Long id, Integer popular) {
        Brand b=new Brand();
        b.setId(id);
        b.setPopular(popular);
        brandMapper.updateById(b);
        return ServerResponse.success();
    }

    @Override
    public ServerResponse updateSort(Long id,Integer sort) {
        Brand b=new Brand();
        b.setId(id);
        b.setSort(sort);
        brandMapper.updateById(b);
        return ServerResponse.success();
    }

    private BrandVo getBrandVo(Brand brand) {
        BrandVo vo=new BrandVo();
        vo.setBrandName(brand.getBrandName());
        vo.setId(brand.getId());
        vo.setImgPath(brand.getImgPath());
        vo.setSort(brand.getSort());
        vo.setPopular(brand.getPopular());
        return vo;
    }


}
