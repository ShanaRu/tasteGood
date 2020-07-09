package com.domain;

import java.util.Date;

public class LeaveMessage {
    private Integer leaveId;
    private Integer menuId;
    private Integer userId;
    private Date leaveTime;
    private String leaveWord;
    private String menuName;

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public Integer getLeaveId() {
        return leaveId;
    }

    public void setLeaveId(Integer leaveId) {
        this.leaveId = leaveId;
    }

    public Integer getMenuId() {
        return menuId;
    }

    public void setMenuId(Integer menuId) {
        this.menuId = menuId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Date getLeaveTime() {
        return leaveTime;
    }

    public void setLeaveTime(Date leaveTime) {
        this.leaveTime = leaveTime;
    }

    public String getLeaveWord() {
        return leaveWord;
    }

    public void setLeaveWord(String leaveWord) {
        this.leaveWord = leaveWord;
    }

    @Override
    public String toString() {
        return "LeaveMessage{" +
                "leaveId=" + leaveId +
                ", menuId=" + menuId +
                ", userId=" + userId +
                ", leaveTime=" + leaveTime +
                ", leaveWord='" + leaveWord + '\'' +
                ", menuName='" + menuName + '\'' +
                '}';
    }
}
