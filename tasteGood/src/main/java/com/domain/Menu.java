package com.domain;

import java.util.Date;
import java.util.List;

public class Menu {
    private int menuId;
    private String menuName;
    private String menuCover;
    private String menuDetail;
    private String tip;
    private Date uploadTime;
    private int collection;
    private String classification;
    private int userId;
    private List<Ingredients> Ingredients;
    private List<Step> Step;

    public List<com.domain.Ingredients> getIngredients() {
        return Ingredients;
    }

    public void setIngredients(List<com.domain.Ingredients> ingredients) {
        Ingredients = ingredients;
    }

    public List<com.domain.Step> getStep() {
        return Step;
    }

    public void setStep(List<com.domain.Step> step) {
        Step = step;
    }

    public int getMenuId() {
        return menuId;
    }

    public void setMenuId(int menuId) {
        this.menuId = menuId;
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

    public int getCollection() {
        return collection;
    }

    public void setCollection(int collection) {
        this.collection = collection;
    }

    public String getClassification() {
        return classification;
    }

    public void setClassification(String classification) {
        this.classification = classification;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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
                ", Ingredients=" + Ingredients +
                ", Step=" + Step +
                '}';
    }
}
