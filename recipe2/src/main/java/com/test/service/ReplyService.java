package com.test.service;

import java.util.List;

import com.test.model.ReplyVO;

public interface ReplyService {
    List<ReplyVO> getRepliesByBoardNo(int bno);
    void addReply(ReplyVO rvo);
    void deleteReply(int rno);
    ReplyVO getReply(int rno);
}
