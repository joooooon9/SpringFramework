package com.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.dao.ReplyDAO;
import com.test.model.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {
    @Autowired
    private ReplyDAO replyDAO;

    @Override
    public List<ReplyVO> getRepliesByBoardNo(int bno) {
        return replyDAO.getRepliesByBoardNo(bno);
    }

    @Override
    public void addReply(ReplyVO rvo) {
        replyDAO.addReply(rvo);
    }

    @Override
    public void deleteReply(int rno) {
        replyDAO.deleteReply(rno);
    }

    @Override
    public ReplyVO getReply(int rno) {
        return replyDAO.getReply(rno);
    }
}
