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
        List<Works> works = worksDao.findWorksByUserId(userId);
        return works;
    }

    @Override
    public Works findWorksByWorkId(Integer workId) {
        Works work=worksDao.findWorksByWorkId(workId);
        return work;
    }

    @Override
    public void updateWork(String workPhoto, String summary, Integer workId, Date workTime) {
        worksDao.updateWork(workPhoto,summary,workId,workTime);
    }

    @Override
    public List<Works> showWorks() {
        List<Works> works=worksDao.showWorks();
        return works;
    }


}
