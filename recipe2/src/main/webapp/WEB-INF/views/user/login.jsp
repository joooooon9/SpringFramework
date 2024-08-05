<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="../resources/css/login.css" rel="stylesheet" type="text/css" />
    <title>로그인</title>
</head>
<body>
    <section>
        <div class="login">
            <form name="login_box" action="login.do" method="post">
                <div>
                    <a href="<%= request.getContextPath() %>/user/login.do"><img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="메인로고"></a>
                </div>
                <div class="label">아이디 :</div>
                <input type="text" id="id" name="id">
                <div class="label">비밀번호 :</div>
                <input type="password" id="pw" name="pw">
                <input type="submit" value="로그인">
                <br>
                <div style="margin-bottom: 10px;">
                    <a href="findPw.do">비밀번호를 잊으셨나요?</a>
                </div>
                <div>계정이 없으신가요? &nbsp; <a href="join.do">회원가입</a></div>
            </form> 
        </div>
    </section>
</body>
</html>
