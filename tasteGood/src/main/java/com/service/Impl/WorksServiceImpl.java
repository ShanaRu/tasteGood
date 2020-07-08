package com.service.Impl;

import com.dao.WorksDao;
import com.domain.Works;
import com.service.WorksService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Date;
import java.util.List;

@Service("worksService")
public class WorksServiceImpl implements WorksService {

    @Autowired
    private WorksDao worksDao;

    @Override
    public void saveWorks(Works works) {
        worksDao.saveWorks(works);
    }

    @Override
    public List<Works> findWorksByUserId(Integer userId) {
        return worksDao.findWorksByUserId(userId);
    }

    @Override
    public Works findWorksByWorkId(Integer workId) {
        return worksDao.findWorksByWorkId(workId);
    }

    @Override
    public void updateWork(String workPhoto, String summary, Integer workId, Date workTime) {
        worksDao.updateWork(workPhoto,summary,workId,workTime);
    }

    @Override
    public List<Works> showWorks() {
        return worksDao.showWorks();
    }

    @Override
    public void deleteWork(Integer workId) {
        worksDao.deleteWork(workId);
    }

    @Override
    public void addLikes(Integer workId, Integer likes) {
        worksDao.addLikes(workId,likes);
    }

    @Override
    public List<Works> getPopularWorks() {
        return worksDao.getPopularWorks();
    }

    @Override
    public Integer countWorksById(Integer userId) {
        return worksDao.countWorksById(userId);
    }
}
