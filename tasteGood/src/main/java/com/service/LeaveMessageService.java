package com.service;

import com.domain.LeaveMessage;

import java.util.List;

public interface LeaveMessageService {
    void addLeaveMessage(LeaveMessage leaveMessage);

    List<LeaveMessage> getLeaveMessageByMenuId(Integer menuId);

    List<LeaveMessage> getLeaveMessageByUserId(Integer userId);

    void deleteLeaveMessage(Integer leaveId);
}
