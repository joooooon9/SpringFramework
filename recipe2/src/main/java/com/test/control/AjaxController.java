package com.test.control;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.model.BoardVO;
import com.test.model.FileVO;
import com.test.service.BoardService;
import com.test.service.MailService;
import com.test.service.UserService;

@RequestMapping(value="/ajax")
@Controller
public class AjaxController {   
	@Autowired
	BoardService boardservice;
    @Autowired
    UserService userService;
    @Autowired
    MailService mailService;
    
    @ResponseBody
    @RequestMapping(value="/checkID.do", method=RequestMethod.GET)
    public String checkID(String id) {
        System.out.println("id::"+id);
        // Database에서 파라미터와 중복되는 id가 존재하는지 확인
        int result = userService.selectById(id);
        System.out.println("값은"+ result);
        if(result > 0) {
            // 아이디 중복
            return "0";
        } else {
            // 아이디 중복X
            return "1";
        }
    }
    @ResponseBody
    @RequestMapping(value="/checkNick.do", method=RequestMethod.GET)
    public String checkNick(String nick) {
        System.out.println("nick::"+nick);
        // Database에서 파라미터와 중복되는 nick가 존재하는지 확인
        int result = userService.selectByNick(nick);
        System.out.println("값은"+ result);
        if(result > 0) {
            // 닉네임 중복
            return "0";
        } else {
            // 닉네임 중복X
            return "1";
        }
    }
    
    @RequestMapping(value = "/loadMore.do", method = RequestMethod.GET)
    @ResponseBody
    public List<BoardVO> loadMore(@RequestParam("offset") int offset, @RequestParam("limit") int limit) {
    	
        List<BoardVO> publicBoardList = boardservice.getPublicBoardListWithPagination(offset, limit);

        for (BoardVO board : publicBoardList) {
        	System.out.println(board);
        	
            FileVO file = boardservice.viewFile(Integer.parseInt(board.getBno()));
            board.setFileVO(file);
        }

        return publicBoardList;
    }
    
}
