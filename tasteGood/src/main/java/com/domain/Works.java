package com.domain;

public class Works {
    private String menuName;
    private Integer menuId;
    private Integer workId;
    private String summary;
    private String workPhoto;
    private Integer likes;

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public Integer getMenuId() {
        return menuId;
    }

    public void setMenuId(Integer menuId) {
        this.menuId = menuId;
    }

    public Integer getWorkId() {
        return workId;
    }

    public void setWorkId(Integer workId) {
        this.workId = workId;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getWorkPhoto() {
        return workPhoto;
    }

    public void setWorkPhoto(String workPhoto) {
        this.workPhoto = workPhoto;
    }

    public Integer getLikes() {
        return likes;
    }

    public void setLikes(Integer likes) {
        this.likes = likes;
    }

    @Override
    public String toString() {
        return "Works{" +
                "menuName='" + menuName + '\'' +
                ", menuId=" + menuId +
                ", workId=" + workId +
                ", summary='" + summary + '\'' +
                ", workPhoto='" + workPhoto + '\'' +
                ", likes=" + likes +
                '}';
    }
}
