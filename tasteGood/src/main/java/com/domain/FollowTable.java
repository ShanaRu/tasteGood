package com.domain;

public class FollowTable {
    private Integer userId;
    private Integer follow;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getFollow() {
        return follow;
    }

    public void setFollow(Integer follow) {
        this.follow = follow;
    }

    @Override
    public String toString() {
        return "followTable{" +
                "userId=" + userId +
                ", follow=" + follow +
                '}';
    }
}
