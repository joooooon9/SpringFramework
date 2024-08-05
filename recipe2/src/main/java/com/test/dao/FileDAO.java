package com.test.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.model.FileVO;

@Repository
public class FileDAO {
    @Autowired
    private SqlSession sqlSession;

    private static final String Namespace = "com.test.mapper.FileMapper";

    public void insert(FileVO fvo) {
        sqlSession.insert(Namespace + ".insert", fvo);
    }

    public FileVO view(int bno) {
        return sqlSession.selectOne(Namespace + ".view", bno);
    }
     
    public void delete(int bno) {
        sqlSession.delete(Namespace + ".delete", bno);
    }

    public void update(FileVO fvo) {
        sqlSession.update(Namespace + ".update", fvo);
    }
}