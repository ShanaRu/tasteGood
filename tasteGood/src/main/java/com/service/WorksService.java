package com.service;

import com.domain.Menu;
import com.domain.Works;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Date;
import java.util.List;

public interface WorksService {
    //保存作品
    void saveWorks(Works works);

    //根据用户id查询作品
    List<Works> findWorksByUserId(Integer userId,Integer page,Integer size);

    //根据workId查询作品
    Works findWorksByWorkId(Integer workId);

    //更新作品信息
    void updateWork(String workPhoto, String summary, Integer workId, Date workTime);

    //按照时间顺序显示所有作品
    List<Works> showWorks(Integer page,Integer size);

    //删除作品
    void deleteWork(Integer workId);

    //点赞+1
    void addLikes(Integer workId,Integer likes);

    //按点赞从大到小
    List<Works> getPopularWorks();

    //用户作品数量
    Integer countWorksById(Integer userId);

    List<Works> recommendWork();

    List<Works> getMenuWorks(Integer menuId);
}
