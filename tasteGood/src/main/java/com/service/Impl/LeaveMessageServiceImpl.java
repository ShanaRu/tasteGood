package com.service.Impl;

import com.dao.LeaveMessageDao;
import com.domain.LeaveMessage;
import com.github.pagehelper.PageHelper;
import com.service.LeaveMessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("leaveMessageService")
public class LeaveMessageServiceImpl implements LeaveMessageService {
    @Autowired
    private LeaveMessageDao leaveMessageDao;

    @Override
    public void addLeaveMessage(LeaveMessage leaveMessage) {
        leaveMessageDao.addLeaveMessage(leaveMessage);
    }

    @Override
    public List<LeaveMessage> getLeaveMessageByMenuId(Integer menuId) {
        return leaveMessageDao.getLeaveMessageByMenuId(menuId);
    }

    @Override
    public List<LeaveMessage> getLeaveMessageByUserId(Integer userId,Integer page,Integer size) {
        PageHelper.startPage(page,size);
        return leaveMessageDao.getLeaveMessageByUserId(userId);
    }

    @Override
    public void deleteLeaveMessage(Integer leaveId) {
        leaveMessageDao.deleteLeaveMessage(leaveId);
    }

    @Override
    public List<LeaveMessage> getAllLeaveMessage(Integer page,Integer size) {
        PageHelper.startPage(page,size);
        return leaveMessageDao.getAllLeaveMessage();
    }
}
