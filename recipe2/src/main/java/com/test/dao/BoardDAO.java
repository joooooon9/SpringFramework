package com.test.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.test.model.BoardVO;
import com.test.model.NoticeVO;

@Repository
public class BoardDAO {
    @Autowired
    private SqlSession sqlSession;

    private static final String Namespace = "com.test.mapper.BoardMapper";

    public void insert(BoardVO bvo) {
        sqlSession.insert(Namespace + ".insert", bvo);
    }

    public BoardVO selectbybno(int bno) {
        return sqlSession.selectOne(Namespace + ".selectbybno", bno);
    }

    public int update(BoardVO bvo) {
        return sqlSession.update(Namespace + ".update", bvo);
    }

    public void delete(int no) {
        sqlSession.update(Namespace + ".delete", no);
    }

    public List<BoardVO> getBoardList(String userno) {
        return sqlSession.selectList(Namespace + ".getBoardList", userno);
    }

    public List<BoardVO> getPublicBoardList() {
        return sqlSession.selectList(Namespace + ".getPublicBoardList");
    }

    public List<BoardVO> getPublicBoardListWithPagination(int offset, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("limit", limit);
        return sqlSession.selectList(Namespace + ".getPublicBoardListWithPagination", params);
    }
    
    public void bhit(int bno) {
        sqlSession.update(Namespace + ".bhit", bno);
    }
    
	public void nhit(int notinum) {
		sqlSession.update(Namespace + ".nhit", notinum);
		
	}

	public void insert(NoticeVO nvo) 
	{
		sqlSession.insert(Namespace + ".noticeinsert", nvo);
	}

	public NoticeVO selectbynotinum(int notinum) 
	{
		return sqlSession.selectOne(Namespace + ".selectbynotinum", notinum);
	}

	public List<NoticeVO> getNoticeList()
	{
		return sqlSession.selectList(Namespace + ".getNoticeList");
	}

    
}
