package com.dao;

import com.domain.LeaveMessage;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LeaveMessageDao {
    @Insert("insert into leaveMessage(userId,menuId,leaveWord,leaveTime,menuName) values(#{userId},#{menuId},#{leaveWord},#{leaveTime},#{menuName})")
    void addLeaveMessage(LeaveMessage leaveMessage);

    @Select("select * from leaveMessage where menuId=#{menuId}")
    List<LeaveMessage> getLeaveMessageByMenuId(Integer menuId);

    @Select("select * from leaveMessage where userId=#{userId}")
    List<LeaveMessage> getLeaveMessageByUserId(Integer userId);

    @Delete("delete from leaveMessage where leaveId=#{leaveId}")
    void deleteLeaveMessage(Integer leaveId);
}
