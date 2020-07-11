package com.service;

import com.domain.Collection;
import com.domain.Menu;

import java.util.List;

public interface CollectionService {
    //根据用户id查询收藏
    List<Collection> findCollectionsByUserId(Integer userId,Integer page,Integer size);

    //更新complete
    void updateComplete(Collection collection);

    //删除收藏
    void deleteCollection(Collection collection);

    //增加收藏
    void addCollection(Collection collection);

    //查找收藏
    Collection findCollectionById(Collection collection);

    //按完成次数排行
    List<Collection> getPopularCollection();

    //用户收藏数量
    Integer countCollectionsById(Integer userId);

}
