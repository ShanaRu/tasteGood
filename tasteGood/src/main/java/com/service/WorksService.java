package com.service;

import com.domain.Works;

import java.util.Date;
import java.util.List;

public interface WorksService {
    //保存作品
    public void saveWorks(Works works);

    //根据用户id查询作品
    public List<Works> findWorksByUserId(Integer userId);

    //根据workId查询作品
    public Works findWorksByWorkId(Integer workId);

    //更新作品信息
    public void updateWork(String workPhoto, String summary, Integer workId, Date workTime);

    //按照时间顺序显示所有作品
    public List<Works> showWorks();

    //删除作品
    public void deleteWork(Integer workId);

    //点赞+1
    public void addLikes(Integer workId,Integer likes);
}
