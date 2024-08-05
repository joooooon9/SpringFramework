package com.test.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.model.ReplyVO;

@Repository
public class ReplyDAO {
    @Autowired
    private SqlSession sqlSession;
    
    private static final String Namespace = "com.test.mapper.ReplyMapper";

    public List<ReplyVO> getRepliesByBoardNo(int bno) {
        return sqlSession.selectList(Namespace + ".getRepliesByBoardNo", bno);
    }

    public void addReply(ReplyVO rvo) {
        sqlSession.insert(Namespace + ".addReply", rvo);
    }

    public void deleteReply(int rno) {
        sqlSession.delete(Namespace + ".deleteReply", rno);
    }

    public ReplyVO getReply(int rno) {
        return sqlSession.selectOne(Namespace + ".getReply", rno);
    }
}
