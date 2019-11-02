package com.fh.shop.admin.param.shop;

import com.fh.shop.admin.common.Page;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class ShopSearch extends Page implements Serializable {
    private String  shopName;
    private BigDecimal minPrice;
    private BigDecimal  maxPrice;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date    minDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date    maxDate;
    private Integer    shopId;
    //分类
    private Integer classifyId1;
    private Integer classifyId2;
    private Integer classifyId3;


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

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    public BigDecimal getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(BigDecimal minPrice) {
        this.minPrice = minPrice;
    }

    public BigDecimal getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(BigDecimal maxPrice) {
        this.maxPrice = maxPrice;
    }

    public Date getMinDate() {
        return minDate;
    }

    public void setMinDate(Date minDate) {
        this.minDate = minDate;
    }

    public Date getMaxDate() {
        return maxDate;
    }

    public void setMaxDate(Date maxDate) {
        this.maxDate = maxDate;
    }

    public Integer getShopId() {
        return shopId;
    }

    public void setShopId(Integer shopId) {
        this.shopId = shopId;
    }
}
