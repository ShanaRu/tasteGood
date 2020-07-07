package com.domain;

public class Collection {
    private Integer complete;
    private Integer userId;
    private Integer menuId;

    public Integer getComplete() {
        return complete;
    }

    public void setComplete(Integer complete) {
        this.complete = complete;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getMenuId() {
        return menuId;
    }

    public void setMenuId(Integer menuId) {
        this.menuId = menuId;
    }

    @Override
    public String toString() {
        return "Collection{" +
                "complete=" + complete +
                ", userId=" + userId +
                ", menuId=" + menuId +
                '}';
    }
}
