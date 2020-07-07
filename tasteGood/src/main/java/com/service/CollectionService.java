package com.service;

import com.domain.Collection;
import com.domain.Menu;

import java.util.List;

public interface CollectionService {
    //根据用户id查询收藏
    public List<Collection> findCollectionsByUserId(Integer userId);

    //根据收藏的menuId查询菜谱
    public List<Menu> showCollections(Integer userId);

    //更新complete
    public void updateComplete(Collection collection);

    //删除收藏
    public void deleteCollection(Collection collection);

    //增加收藏
    public void addCollection(Collection collection);

    //查找收藏
    public Collection findCollectionById(Collection collection);
}
