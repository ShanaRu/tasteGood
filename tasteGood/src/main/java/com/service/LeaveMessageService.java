package com.service;

import com.domain.LeaveMessage;

import java.util.List;

public interface LeaveMessageService {
    void addLeaveMessage(LeaveMessage leaveMessage);

    List<LeaveMessage> getLeaveMessageByMenuId(Integer menuId);

    List<LeaveMessage> getLeaveMessageByUserId(Integer userId,Integer page,Integer size);

    void deleteLeaveMessage(Integer leaveId);

    List<LeaveMessage> getAllLeaveMessage(Integer page,Integer size);
}
