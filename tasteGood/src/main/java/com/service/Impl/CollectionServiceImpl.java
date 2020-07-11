package com.service.Impl;

import com.dao.CollectionDao;
import com.dao.MenuDao;
import com.domain.Collection;
import com.domain.Menu;
import com.github.pagehelper.PageHelper;
import com.service.CollectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
@Service("collectionService")
public class CollectionServiceImpl implements CollectionService {

    @Autowired
    private MenuDao menuDao;
    @Autowired
    private CollectionDao collectionDao;

    @Override
    public List<Collection> findCollectionsByUserId(Integer userId,Integer page,Integer size) {
        PageHelper.startPage(page,size);
        return collectionDao.findCollectionsByUserId(userId);
    }

    @Override
    public void updateComplete(Collection collection) {
        collectionDao.updateComplete(collection);
    }

    @Override
    public void deleteCollection(Collection collection) {
        collectionDao.deleteCollection(collection);
    }

    @Override
    public void addCollection(Collection collection) {
        collectionDao.addCollection(collection);
    }

    @Override
    public Collection findCollectionById(Collection collection) {
        return collectionDao.findCollectionById(collection);
    }

    @Override
    public List<Collection> getPopularCollection() {
        return collectionDao.getPopularCollection().subList(0,7);
    }

    @Override
    public Integer countCollectionsById(Integer userId) {
        return collectionDao.countCollectionsById(userId);
    }
}
