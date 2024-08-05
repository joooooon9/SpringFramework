<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="../resources/css/newPw.css" rel="stylesheet" type="text/css" />
    <script src="../resources/js/jquery-3.7.1.js"></script>
    <title>비밀번호 재설정</title>
<script>
window.onload = function()
{
	$("#newPw").focus();
	
	//인증 버튼 클릭됨.
	$("#login_box").submit(function()
	{
		if($("#newPw").val() == "")
		{
			alert("새로운 비밀번호를 입력하세요.");
			$("#newPw").focus();
			return false;
		}
		if($("#pwc").val() == "")
		{
			alert("비밀번호 확인을 입력하세요.");
			$("#pwc").focus();
			return false;
		}
		if(confirm("변경한 비밀번호로 로그인해주세요!") == false)
		{
			return false;
		}
		return true;
	});	
}
console.log("${param.id}")
console.log("${param.email}")
</script>
</head>
<body>
    <section>
        <div class="login">
            <form name="login_box" action="newPw.do" method="post">
	            <input type="hidden" id="id" name="id" value="${param.id}">
                <div>
                    <a href="<%= request.getContextPath() %>/user/login.do"><img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="메인로고"></a>
                </div>
                <div class="label">새로운 비밀번호 :</div>
                <input type="password" id="newPw" name="newPw">
                <div class="label">비밀번호 확인:</div>
                <input type="password" id="pwc" name="pwc">
                <input type="submit" value="비밀번호 변경">
            </form> 
        </div>
    </section>
</body>
</html>