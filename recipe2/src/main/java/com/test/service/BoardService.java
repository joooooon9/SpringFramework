package com.test.service;

import java.util.List;
import com.test.model.BoardVO;
import com.test.model.FileVO;
import com.test.model.NoticeVO;

public interface BoardService {
    String WriteOK(BoardVO bvo);
    BoardVO selectbybno(int bno);
	void NWriteOK(NoticeVO nvo);
	NoticeVO selectbynotinum(int notinum);
    int update(BoardVO bvo);
    void delete(int bno);
    List<BoardVO> getBoardList(String userno);  
    List<BoardVO> getPublicBoardList();  
    List<BoardVO> getPublicBoardListWithPagination(int offset, int limit);
    
    void bhit(int bno);
    void nhit(int notinum);
    
    void insertFile(FileVO fvo);
    FileVO viewFile(int bno);
    void deleteFile(int bno);
    void updateFile(FileVO fvo);
	List<NoticeVO> getNoticeList();
}
