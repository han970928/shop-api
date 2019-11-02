package com.fh.shop.admin.vo.shop;


import java.io.Serializable;

public class ShopVo  implements Serializable {
    private Long    id;
    private String  shopName;
    private String price;
    private String  imgPath;
    private String productiveTime;
    private Long      stock;
    private Integer   isHot;
    private Integer   isShelf;
    private String    brandName;
    private Long     brandId;
    //分类
    private String classifyName;


    public String getClassifyName() {
        return classifyName;
    }

    public void setClassifyName(String classifyName) {
        this.classifyName = classifyName;
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

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public String getProductiveTime() {
        return productiveTime;
    }

    public void setProductiveTime(String productiveTime) {
        this.productiveTime = productiveTime;
    }
}
