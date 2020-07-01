package com.service.Impl;

import com.dao.WorksDao;
import com.domain.Works;
import com.service.WorksService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

@Service("worksService")
public class WorksServiceImpl implements WorksService {

    @Autowired
    private WorksDao worksDao;

    @Override
    public void saveWorks(Works works) {
        worksDao.saveWorks(works);
    }
}
