package com.test.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.test.dao.BoardDAO;
import com.test.dao.FileDAO;
import com.test.dao.ReplyDAO;
import com.test.dao.UserDAO;
import com.test.model.BoardVO;
import com.test.model.FileVO;
import com.test.model.NoticeVO;

@Service
public class BoardServiceImpl implements BoardService {
    @Autowired
    UserDAO dao;
    @Autowired
    BoardDAO bdao;
    @Autowired
    FileDAO fdao;
    @Autowired
    ReplyDAO rdao;

    @Override
    public String WriteOK(BoardVO bvo) {
        bdao.insert(bvo);
        return bvo.getBno();
    }

    @Override
    public BoardVO selectbybno(int bno) {
        return bdao.selectbybno(bno);
    }

    @Override
    public int update(BoardVO bvo) {
        return bdao.update(bvo);
    }

    @Override
    @Transactional
    public void delete(int bno) {
       bdao.delete(bno);
    }

    @Override
    public List<BoardVO> getBoardList(String userno) {
        return bdao.getBoardList(userno);
    }

    @Override
    public List<BoardVO> getPublicBoardList() {
        return bdao.getPublicBoardList();
    }

    @Override
    public List<BoardVO> getPublicBoardListWithPagination(int offset, int limit) {
        return bdao.getPublicBoardListWithPagination(offset, limit);
    }

    
    @Override
    public void bhit(int bno) {
        bdao.bhit(bno);
    }
	@Override
	public void nhit(int notinum) 
	{
		bdao.nhit(notinum);
		
	}
	
    @Override
    public void insertFile(FileVO fvo) {
        fdao.insert(fvo);
    }

    @Override
    public FileVO viewFile(int bno) {
        return fdao.view(bno);
    }

    @Override
    public void deleteFile(int bno) {
        fdao.delete(bno);
    }

    @Override
    public void updateFile(FileVO fvo) {
        fdao.update(fvo);
    }

	@Override
	public void NWriteOK(NoticeVO nvo) 
	{
		bdao.insert(nvo);		
	}

	@Override
	public NoticeVO selectbynotinum(int notinum) 
	{
		return bdao.selectbynotinum(notinum);
	}

	@Override
	public List<NoticeVO> getNoticeList() 
	{
		return bdao.getNoticeList();
	}


}
