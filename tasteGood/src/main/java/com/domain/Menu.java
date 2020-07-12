package com.domain;

import java.util.Date;
import java.util.List;

public class Menu {
    private Integer menuId;
    private String menuName;
    private String menuCover;
    private String menuDetail;
    private String tip;
    private Date uploadTime;
    private Integer collection;
    private String classification;
    private Integer userId;
    private Integer totalComplete;
    private List<Ingredients> Ingredients;
    private List<Steps> Steps;

    public Integer getTotalComplete() {
        return totalComplete;
    }

    public void setTotalComplete(Integer totalComplete) {
        this.totalComplete = totalComplete;
    }

    public List<com.domain.Ingredients> getIngredients() {
        return Ingredients;
    }

    public void setIngredients(List<com.domain.Ingredients> ingredients) {
        Ingredients = ingredients;
    }

    public List<Steps> getSteps() {
        return Steps;
    }

    public void setSteps(List<Steps> steps) {
        Steps = steps;
    }

    public Integer getMenuId() {
        return menuId;
    }

    public void setMenuId(Integer menuId) {
        this.menuId = menuId;
    }

    public Integer getCollection() {
        return collection;
    }

    public void setCollection(Integer collection) {
        this.collection = collection;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public String getMenuCover() {
        return menuCover;
    }

    public void setMenuCover(String menuCover) {
        this.menuCover = menuCover;
    }

    public String getMenuDetail() {
        return menuDetail;
    }

    public void setMenuDetail(String menuDetail) {
        this.menuDetail = menuDetail;
    }

    public String getTip() {
        return tip;
    }

    public void setTip(String tip) {
        this.tip = tip;
    }

    public Date getUploadTime() {
        return uploadTime;
    }

    public void setUploadTime(Date uploadTime) {
        this.uploadTime = uploadTime;
    }

    public String getClassification() {
        return classification;
    }

    public void setClassification(String classification) {
        this.classification = classification;
    }

    @Override
    public String toString() {
        return "Menu{" +
                "menuId=" + menuId +
                ", menuName='" + menuName + '\'' +
                ", menuCover='" + menuCover + '\'' +
                ", menuDetail='" + menuDetail + '\'' +
                ", tip='" + tip + '\'' +
                ", uploadTime=" + uploadTime +
                ", collection=" + collection +
                ", classification='" + classification + '\'' +
                ", userId=" + userId +
                ", totalComplete=" + totalComplete +
                ", Ingredients=" + Ingredients +
                ", Steps=" + Steps +
                '}';
    }
}
