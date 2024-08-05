<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="../resources/css/findPw.css" rel="stylesheet" type="text/css" />
    <script src="../resources/js/jquery-3.7.1.js"></script>
    <title>비밀번호 재설정</title>
<script>
window.onload = function()
{
	$("#uid").focus();
	
	//인증 버튼 클릭됨.
	$("#login_box").submit(function()
	{
		if($("#uid").val() == "")
		{
			alert("아이디를 입력하세요.");
			$("#uid").focus();
			return false;
		}
		if($("#email").val() == "")
		{
			alert("이메일을 입력하세요.");
			$("#email").focus();
			return false;
		}
        // 인증코드 확인
        if ($("#checkc").val() == "") {
            alert("인증코드가 입력되지 않았습니다.");
            $("#checkc").focus();
            return false;
        } else if ($("#checkc").val() != code) {
            alert("인증코드가 일치하지 않습니다.");
            $("#checkc").focus();
            return false;
        } else {
            return true;
        }
	});	
}
function checkUser() {
    var contextPath = '<%=request.getContextPath()%>';
    $.ajax({
        url: contextPath + "/checkuser.do",
        type: "get",
        data: {
            id: $("#id").val(),
            email: $("#email").val()
        },
        success: function(data) {
            if (data == '0') {
                alert("가입한 정보가 없습니다.");
                $("#id").val("");
                $("#id").focus();
            } else if (data == '1') {
                $.ajax({
                    url: contextPath + "/sendmail.do",
                    type: "get",
                    data: { email: $("#email").val() },
                    success: function(response) {
                        if(response == "0") {
                            alert("전송 실패");
                        } else {    
                            var code = response;
                            alert("이메일을 발송했습니다.\n인증 코드를 확인해주세요.");
                            // 추가적으로 인증 코드를 처리할 로직을 여기에 추가할 수 있습니다.
                        }
                    },
                    error: function() {
                        alert("메일 발송 중 오류가 발생했습니다.");
                    }
                });
            }
        },
        error: function() {
            alert("예외 발생!");
        }
    });
}
</script>
</head>
<body>
    <section>
        <div class="login">
            <form name="login_box" id="login_box" action="newPw.do" method="get">
                <div>
                    <a href="<%= request.getContextPath() %>/user/login.do"><img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="메인로고"></a>
                </div>
                <div class="label_id">아이디 :</div>
                <input type="text" id="id" name="id">
                <div class="label_id">이메일 :</div>
                <div class="email-input">
                    <input type="text" id="email" name="email">
                    <input type="button" value="인증코드 전송" onclick="checkUser()">
                </div>
                <div class="label_id">인증코드 :</div>
                <input type="text" id="checkcode" name="checkcode">
                <input type="submit" value="인증">
            </form> 
        </div>
    </section>
</body>
</html>
