package com.test.service;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Service;
@Service
public class MailServiceImpl implements MailService
{
	private String from = "wjdwns9988@naver.com";  //보내는 사람 메일주소
	private String title = "인증코드 발송 메일입니다."; //메일 제목
	private String body;  //메일 내용
	private String id = "wjdwns9988";    //계정 아이디
	private String pw = "486979long";    //계정 비밀번호
	
	
	//인증코드생성
	public String AuthCode(int max)
	{
		String datas = "01234567890abcdefghijklmnopqrstuvwxyz";
		String code = "";
		for(int i = 0 ; i < max; i++)
		{
			int rand = (int)(Math.random() * 100);
			rand = rand % datas.length();
			code += datas.charAt(rand);
		}
		return code;
	}
	
	//메일발송
	public String send(String email) 
	{
		try
		{
			System.out.println("메일 발송을 시작합니다.");
			
			Properties clsProp = System.getProperties();
			
			// 메일 서버 주소
			clsProp.put( "mail.smtp.host", "smtp.naver.com" );
			
			// 메일 서버 포트 번호
			clsProp.put( "mail.smtp.port", 465 );
			
			// 네이버 로그인인증
			clsProp.put("mail.smtp.auth", "true"); 
			clsProp.put("mail.smtp.ssl.enable", "true"); 
			clsProp.put("mail.smtp.ssl.trust", "smtp.naver.com");
			clsProp.put("mail.smtp.ssl.protocols", "TLSv1.2");
			
			Session clsSession = Session.getInstance( clsProp, new Authenticator()
			{
				public PasswordAuthentication getPasswordAuthentication()
				{
					// 인증 아이디/비밀번호를 저장한다.
					return new PasswordAuthentication( id, pw );
				}
			} );
			
			Message clsMessage = new MimeMessage( clsSession );
			
			// 발신자 이메일 주소를 설정한다.
			clsMessage.setFrom( new InternetAddress( from ) );
			
			// 수신자 이메일 주소를 설정한다.
			clsMessage.addRecipient( Message.RecipientType.TO, new InternetAddress( email ) );
			
			// 제목을 저장한다.
			clsMessage.setSubject( title );
			
			// 메일 내용을 저장한다. 
			String authCode = AuthCode(6);
            body = "오늘뭐먹지 인증코드입니다.<br>인증코드: " + authCode;
			clsMessage.setContent( body , "text/html;charset=utf-8" );
			
			// 메일 전송
			Transport.send( clsMessage );
			
			System.out.println("메일 발송을 종료합니다.");
			
			return authCode;
		}catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("메일 발송을 종료합니다.");
			return "";
		}
	}

}
