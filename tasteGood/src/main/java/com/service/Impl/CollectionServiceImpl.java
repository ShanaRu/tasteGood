package com.service.Impl;

import com.dao.CollectionDao;
import com.dao.MenuDao;
import com.domain.Collection;
import com.domain.Menu;
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
    public List<Collection> findCollectionsByUserId(Integer userId) {
        return collectionDao.findCollectionsByUserId(userId);
    }

    @Override
    public List<Menu> showCollections(Integer userId) {
        List<Collection> collections=collectionDao.findCollectionsByUserId(userId);//查询收藏表
        List<Menu> menus = new ArrayList<>();
        for(Collection collection:collections){
            int mid=collection.getMenuId();
            menus.add(menuDao.findMenuByMenuId(mid));
        }
        return menus;
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


}
