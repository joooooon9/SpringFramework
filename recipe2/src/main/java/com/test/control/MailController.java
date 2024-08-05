package com.test.control;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.service.MailService;
import com.test.service.UserService;

@Controller
public class MailController {
	@Autowired
	MailService mailservice;
	@Autowired
	UserService userservice;

	@ResponseBody
	@RequestMapping(value = "/sendmail.do")
	public String sendmail(HttpServletRequest req, HttpServletResponse rsp, @RequestParam("email") String email)
			throws IOException {
		String code = mailservice.send(email);
		System.out.println("인증코드는: "+ code);
		if(code != "")
		{
			return code;
		}else
		{
			return "0";
		}
	}
	
	//비밀번호 재설정 인증메일
    @ResponseBody
    @RequestMapping(value="/checkuser.do", method=RequestMethod.GET)
    public String checkUser(String id,String email) {
        System.out.println("id::"+id);
        System.out.println("email::"+email);
        // Database에서 파라미터와 중복되는 id가 존재하는지 확인
        int result = userservice.selectByUser(id,email);
        System.out.println("값은"+ result);
        if(result > 0) {
            // 아이디가 있으면
            return "1";
        } else {
            // 아이디가 없으면
            return "0";
        }
    }
}
