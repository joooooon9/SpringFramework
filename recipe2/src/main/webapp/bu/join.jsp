<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="resources/css/join.css" rel="stylesheet" type="text/css" />
    <title>회원가입</title>
</head>
<body>
    <section>
        <div class="login">
            <form name="login_box" action="login.jsp" method="get">
                <div class="logo">
                    <img src="resources/img/logo.png" alt="로고">
                </div>
                <div class="label">아이디 :</div>
                <input type="text" id="uid" name="uid">
                <span id="msg_box"></span>
                <div class="label">닉네임 :</div>
                <input type="text" id="nick" name="nick">
                <div class="label">비밀번호 :</div>
                <input type="text" id="upw" name="upw">
                <div class="label">비밀번호 확인 :</div>
                <input type="text" id="uname" name="uname">
                <div class="label">이름 :</div>
                <input type="text" id="pwc" name="pwc">
                <div class="label">이메일 :</div>
                <input type="text" id="email" name="email">
                <input type="button" value="인증코드 발송">
                <div class="label">인증코드 :</div>
                <input type="text" id="upw" name="upw">
                <input type="submit" value="회원가입">
                <br>
                <div class="help">
                    <div>계정이 있으신가요? &nbsp; <a href="login.jsp">로그인</a>
                </div>
            </form> 
        </div>
    </section>
</body>
</html>