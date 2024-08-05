package com.test.control;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.test.model.FileVO;
import com.test.model.UserVO;
import com.test.service.UserService;

@RequestMapping(value = "/user")
@Controller
public class UserController {
    @Autowired
    private UserService userservice;
    
    //private final static String uploadPath = "D:\\JJ\\Spring\\recipe2\\src\\main\\webapp\\resources\\profile";
    //private final static String uploadPath = "D:\\CGC\\Spring\\recipe\\src\\main\\webapp\\resources\\profile";
    @RequestMapping(value="/login.do", method = RequestMethod.GET)
    public String login() {
        return "user/login";
    }
    @RequestMapping(value="/login.do", method = RequestMethod.POST)
	public void login(UserVO vo,HttpServletRequest req,HttpServletResponse rsp) throws IOException 
    {
    	UserVO loginVO = userservice.selectLogin(vo);
    	
		rsp.setContentType("text/html;charset=utf-8");
		PrintWriter pw = rsp.getWriter();
		
		if(loginVO != null) {
			//2.정보가 존재하는 경우 session에 login user 정보 담기
			HttpSession session = req.getSession();
			session.setAttribute("login", loginVO);
			//3.로그인 처리 후 메인페이지 이동
	        pw.append("<script>alert('로그인 성공!');location.href='"+req.getContextPath()+"/board/index.do'</script>");
			//return "redirect:/";
		}else {
			//4.user 정보가 없는 경우 다시 login 페이지로 이동
			pw.append("<script>alert('로그인실패!');location.href='login.do'</script>");
			//return "redirect:/user/login.do";
		}
		pw.flush();
		
	}
    @RequestMapping(value="logout.do")
    public String logout(HttpServletRequest request) {
        request.getSession().setAttribute("login", null);
        return "redirect:/board/index.do";
    }

    // 회원가입 페이지 이동
    @RequestMapping(value="/join.do", method = RequestMethod.GET)
    public String join() {
        return "user/join";
    }

    @RequestMapping(value="/join.do", method = RequestMethod.POST)
    public String join(UserVO vo, HttpServletRequest req, HttpServletResponse rsp) throws IOException {
    	
		System.out.println("uid::"+vo.getId());
		System.out.println("upw::"+vo.getPw());
		System.out.println("uname::"+vo.getName());
		System.out.println("nick::"+vo.getNick());
		System.out.println("email::"+vo.getEmail());
        userservice.Join(vo);
        return "redirect:/user/login.do";  // 회원가입 후 로그인 페이지로 리다이렉트
    }
    
    // 비밀번호찾기 페이지 이동
    @RequestMapping(value="/findPw.do", method = RequestMethod.GET)
    public String findpw() {
        return "user/findPw";
    }
    // 비밀번호 재설정 페이지이동
    @RequestMapping(value="/newPw.do", method = RequestMethod.GET)
    public String newpw() {
        return "user/newPw";
    }
    
    // 비밀번호 재설정 완료
    @RequestMapping(value="/newPw.do", method = RequestMethod.POST)
    public String newpwOK(@RequestParam("newPw")String pw,String id) 
    {
    	userservice.newpwOK(pw,id);
    	return "redirect:/user/login.do";
    }
    
    // 마이페이지 화면
    @RequestMapping(value="/mypage.do", method = RequestMethod.GET)
    public String mypage(HttpServletRequest request) 
    {
		UserVO login = (UserVO)request.getSession().getAttribute("login");
		if( login == null)
		{
			return "redirect:index.do";
		}
        return "user/mypage";
    }
    // 마이페이지 변경완료
    @ResponseBody
    @RequestMapping(value="/mypageok.do", method = RequestMethod.POST)
    public String mypageOK(HttpServletRequest request, UserVO vo, @RequestParam("imgFile") MultipartFile file) throws IllegalStateException, IOException 
    {
    	String uploadPath = request.getSession().getServletContext().getRealPath("/resources/profile");
    	System.out.println("파일경로설정 : " + uploadPath);
    	// 리퀘스트 파라메타로 받은 new_vo
    	// 유저 번호로 db에서 old_vo를 생성
		UserVO login = (UserVO)request.getSession().getAttribute("login");
		if( login == null)
		{
			return "ERROR";
		}
        File newdir = new File(uploadPath);
        if (!newdir.exists()) {
            newdir.mkdirs();
        }
        String originalFileName = file.getOriginalFilename();
        if(originalFileName != null && !originalFileName.equals(""))
        {
        	UUID uuid = UUID.randomUUID();
        	String savedFileName = uuid.toString() + "_" + originalFileName;
        	File newFile = new File(uploadPath + File.separator + savedFileName);
        	file.transferTo(newFile);
        	
        	// 새 프로필 사진으로 변경
        	vo.setBfname(originalFileName);
        	vo.setBpname(savedFileName);
        }else
        {
        	//old_vo에서 프로필 사진 정보를 new_vo에 주입
        }
        vo.setUserno(login.getUserno());
        // new_vo로 db갱신
        userservice.Profile(vo);            
		
        return "ok";
    }

}
