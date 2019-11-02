package com.fh.shop.admin.po.shop;

import com.baomidou.mybatisplus.annotation.TableField;
import com.fh.shop.admin.po.brand.Brand;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;


public class Shop implements Serializable {
    private Long    id;
    private String  shopName;
    private BigDecimal price;
    private String  imgPath;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date   productiveTime;
    private Long      stock;
    private Integer   isHot;
    private Integer   isShelf;
    private String  brandName;
    @TableField(exist = false)// 不对应数据库,前台展示用
    private Brand   b=new Brand();
    //数据库对应
    private Long     brandId;
    //分类
    private Integer classifyId1;
    private Integer classifyId2;
    private Integer classifyId3;
    @TableField(exist = false)// 不对应数据库,前台展示用
    private String   classifyName;


    public Brand getB() {
        return b;
    }

    public void setB(Brand b) {
        this.b = b;
    }

    public String getClassifyName() {
        return classifyName;
    }

    public void setClassifyName(String classifyName) {
        this.classifyName = classifyName;
    }

    public Integer getClassifyId1() {
        return classifyId1;
    }

    public void setClassifyId1(Integer classifyId1) {
        this.classifyId1 = classifyId1;
    }

    public Integer getClassifyId2() {
        return classifyId2;
    }

    public void setClassifyId2(Integer classifyId2) {
        this.classifyId2 = classifyId2;
    }

    public Integer getClassifyId3() {
        return classifyId3;
    }

    public void setClassifyId3(Integer classifyId3) {
        this.classifyId3 = classifyId3;
    }

    public Long getBrandId() {
        return brandId;
    }

    public void setBrandId(Long brandId) {
        this.brandId = brandId;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public Long getStock() {
        return stock;
    }

    public void setStock(Long stock) {
        this.stock = stock;
    }

    public Integer getIsHot() {
        return isHot;
    }

    public void setIsHot(Integer isHot) {
        this.isHot = isHot;
    }

    public Integer getIsShelf() {
        return isShelf;
    }

    public void setIsShelf(Integer isShelf) {
        this.isShelf = isShelf;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public Date getProductiveTime() {
        return productiveTime;
    }

    public void setProductiveTime(Date productiveTime) {
        this.productiveTime = productiveTime;
    }
}
