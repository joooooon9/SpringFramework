package com.test.control;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.test.model.BoardVO;
import com.test.model.FileVO;
import com.test.model.NoticeVO;
import com.test.model.ReplyVO;
import com.test.model.UserVO;
import com.test.service.BoardService;
import com.test.service.ReplyService;

@RequestMapping(value = "/board")
@Controller
public class BoardController {
    @Autowired
    BoardService boardservice;
    
    @Autowired
    ReplyService replyService;
    
//  @Autowired
//  ServletContext context;
  
  //context.getRealPath("resource/upload")로 절대 경로에 접근할 수 있다.
  
  // 파일 저장 경로 설정
    //private final static String uploadPath = "D:\\JJ\\Spring\\recipe2\\src\\main\\webapp\\resources\\upload";
    //private final static String uploadPath = "D:\\CGC\\Spring\\recipe\\src\\main\\webapp\\resources\\upload";
    
    // 나의레시피화면
    @RequestMapping(value = "/index.do", method = RequestMethod.GET)
    public String index(HttpServletRequest request, Locale locale, Model model) {
        HttpSession session = request.getSession();
        UserVO loginVO = (UserVO) session.getAttribute("login");

        if (loginVO == null) {
            return "redirect:/user/login.do";
        } else {
            List<BoardVO> boardList = boardservice.getBoardList(loginVO.getUserno());

            for (BoardVO board : boardList) {
                FileVO file = boardservice.viewFile(Integer.parseInt(board.getBno()));
                board.setFileVO(file);
            }

            model.addAttribute("boardList", boardList);
            return "index";
        }
    }

    // 공개레시피 리스트
    @RequestMapping(value = "/share.do", method = RequestMethod.GET)
    public String share(HttpServletRequest request, Locale locale, Model model) {
        List<BoardVO> publicBoardList = boardservice.getPublicBoardList();
        
        for (BoardVO board : publicBoardList) {
            FileVO file = boardservice.viewFile(Integer.parseInt(board.getBno()));
            board.setFileVO(file);
        }

        model.addAttribute("publicBoardList", publicBoardList);
        return "board/share";
    }

    // 룰렛
    @RequestMapping(value = "/random.do", method = RequestMethod.GET)
    public String randum(HttpServletRequest request, Locale locale, Model model) {
        return "board/random";
    }

    // 공지사항
    @RequestMapping(value = "/notice.do", method = RequestMethod.GET)
    public String notice(HttpServletRequest request, Locale locale, Model model) {
        List<NoticeVO> noticeList = boardservice.getNoticeList();
        model.addAttribute("noticeList", noticeList);
        return "board/notice";
    }
    // 공지사항 글쓰기
    @RequestMapping(value = "/notice_write.do", method = RequestMethod.GET)
    public String notice_w(HttpServletRequest request, Locale locale, Model model) {
    	return "board/notice_write";
    }
    // 공지사항 글쓰기완료
    @RequestMapping(value = "/notice_writeOK.do", method = RequestMethod.POST)
    public String notice_wOK(NoticeVO nvo,HttpServletRequest request, Locale locale, Model model) {
        UserVO login = (UserVO) request.getSession().getAttribute("login");
        if (!login.getIsadmin().equals("Y")) {
            return "redirect:index.do";
        }
        nvo.setUserno(login.getUserno());
        boardservice.NWriteOK(nvo);
        
        return "redirect:/board/notice_view.do?bno=" + nvo.getNotinum();
    }
    // 공지사항 글보기
    @RequestMapping(value = "/notice_view.do", method = RequestMethod.GET)
    public String notice_v(@RequestParam(value = "bno", defaultValue = "0")int notinum, HttpServletRequest request, Locale locale, Model model) {
        if (notinum == 0) {
            return "redirect:/board/index.do";
        }
        boardservice.nhit(notinum);
        NoticeVO nvo = boardservice.selectbynotinum(notinum);
        model.addAttribute("nvo",nvo);
        return "board/notice_view";
    }

    // 글쓰기화면
    @RequestMapping(value = "/write.do", method = RequestMethod.GET)
    public String write(HttpServletRequest request, Locale locale, Model model) {
        return "board/write";
    }

    // 글쓰기완료
    @RequestMapping(value = "/writeok.do", method = RequestMethod.POST)
    public String writeOK(BoardVO bvo, @RequestParam("attach") MultipartFile file, HttpServletRequest request, Model model) 
            throws IllegalStateException, IOException {
        UserVO login = (UserVO) request.getSession().getAttribute("login");
        if (login == null) {
            return "redirect:index.do";
        }
        bvo.setUserno(login.getUserno());
        boardservice.WriteOK(bvo);
        
    	String uploadPath = request.getSession().getServletContext().getRealPath("/resources/upload");
    	System.out.println("파일경로설정 : " + uploadPath);

        if (!file.isEmpty()) {
            String originalFileName = file.getOriginalFilename();
            UUID uuid = UUID.randomUUID();
            String savedFileName = uuid.toString() + "_" + originalFileName;
            File newFile = new File(uploadPath + File.separator + savedFileName);
            file.transferTo(newFile);

            FileVO fvo = new FileVO();
            fvo.setBfname(originalFileName);
            fvo.setBpname(savedFileName);
            fvo.setBno(Integer.parseInt(bvo.getBno()));
            boardservice.insertFile(fvo);
        }
        return "redirect:/board/view.do?bno=" + bvo.getBno();
    }

    // 글보기화면
    @RequestMapping(value = "/view.do", method = RequestMethod.GET)
    public String view(@RequestParam(value = "bno", defaultValue = "0") int bno, HttpServletRequest request, Model model) {
        if (bno == 0) {
            return "redirect:/board/index.do";
        }
        // 조회수 증가
        boardservice.bhit(bno);
        
        BoardVO bvo = boardservice.selectbybno(bno);
        List<ReplyVO> replyList = replyService.getRepliesByBoardNo(bno); // 후기 리스트 가져오기
        UserVO loginUser = (UserVO) request.getSession().getAttribute("login");

        model.addAttribute("bvo", bvo);
        model.addAttribute("replyList", replyList); // 후기 리스트를 모델에 추가
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("isShared", "S".equals(bvo.getIsshare()));

        return "board/view";
    }

    // 글 수정
    @RequestMapping(value = "/modify.do", method = RequestMethod.GET)
    public String modify(@RequestParam(value = "no", defaultValue = "0") int bno, HttpServletRequest request, Model model) {
        BoardVO bvo = boardservice.selectbybno(bno);
        FileVO file = boardservice.viewFile(bno);
        model.addAttribute("bvo", bvo);
        model.addAttribute("file", file);
        return "board/modify";
    }

    // 글 수정완료
    @RequestMapping(value = "/modifyOK.do", method = RequestMethod.POST)
    public String modifyOK(BoardVO bvo, @RequestParam("attach") MultipartFile file, HttpServletRequest request) 
            throws IllegalStateException, IOException {
    	String uploadPath = request.getSession().getServletContext().getRealPath("/resources/upload");
    	System.out.println("파일경로설정 : " + uploadPath);
        if (!file.isEmpty()) {
            String originalFileName = file.getOriginalFilename();
            UUID uuid = UUID.randomUUID();
            String savedFileName = uuid.toString() + "_" + originalFileName;
            File newFile = new File(uploadPath + File.separator + savedFileName);
            file.transferTo(newFile);

            FileVO fvo = new FileVO();
            fvo.setBfname(originalFileName);
            fvo.setBpname(savedFileName);
            fvo.setBno(Integer.parseInt(bvo.getBno()));
            boardservice.updateFile(fvo);
        }
        int result = boardservice.update(bvo);
        if(result > 0) {
            return "redirect:/board/view.do?bno=" + bvo.getBno();
        } else {
            return "redirect:/board/modify.do?no=" + bvo.getBno() + "&updateYN=N";
        }
    }

    // 글삭제
    @RequestMapping(value = "/delete.do", method = RequestMethod.GET)
    public String delete(@RequestParam("bno") int bno, HttpServletRequest request) {
        UserVO login = (UserVO) request.getSession().getAttribute("login");
        if (login == null) {
            return "redirect:/user/login.do";
        }
        
        
        // 게시물의 정보를 가져옵니다.
        BoardVO board = boardservice.selectbybno(bno);
        
//        replyService.deleteReply(bno);
//        boardservice.deleteFile(bno);
        boardservice.delete(bno);
        
        // isshare 필드에 따라 리다이렉트할 페이지를 결정합니다.
        if ("S".equals(board.getIsshare())) {
            return "redirect:/board/share.do";
        }
        
        return "redirect:/board/index.do";
    }

    // 첨부파일 내려받기
//    @RequestMapping(value = "/down.do")
//    public void Down(String no, HttpServletResponse response) throws IOException {
//        if (no == null) {
//            response.sendRedirect("index.do");
//            return;
//        }
//        
//        FileVO fileVO = boardservice.viewFile(Integer.parseInt(no));
//
//        File file = new File(uploadPath, fileVO.getBpname());
//        String encodedFileName = new String(fileVO.getBfname().getBytes("UTF-8"), "ISO-8859-1");
//
//        response.setContentType("application/download");
//        response.setContentLength((int) file.length());
//        response.setHeader("Content-Disposition", "attachment;filename=\"" + encodedFileName + "\"");
//
//        OutputStream os = response.getOutputStream();
//        FileInputStream fis = new FileInputStream(file);
//        FileCopyUtils.copy(fis, os);
//        fis.close();
//        os.close();
//    }
    
    //요리후기 리스트
    @ResponseBody
    @RequestMapping(value = "/getReplies.do", method = RequestMethod.GET)
    public List<ReplyVO> getReplies(@RequestParam("bno") int bno) {
        return replyService.getRepliesByBoardNo(bno);
    }
    // 요리후기 남기기
    @ResponseBody
    @RequestMapping(value = "/addReply.do", method = RequestMethod.POST)
    public String addReply(ReplyVO reply) {
        replyService.addReply(reply);
        return "success";
    }
    // 요리후기 삭제하기
    @RequestMapping(value = "/deleteReply.do", method = RequestMethod.POST)
    @ResponseBody
    public String deleteReply(@RequestParam("rno") int rno, HttpSession session) {
        UserVO loginUser = (UserVO) session.getAttribute("login");
        ReplyVO reply = replyService.getReply(rno);

        if (loginUser != null && reply.getUserno().equals(loginUser.getUserno())) {
            replyService.deleteReply(rno);
            return "success";
        } else {
            return "fail";
        }
    }
    
}
