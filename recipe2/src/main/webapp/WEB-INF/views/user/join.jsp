<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="../resources/css/join.css" rel="stylesheet" type="text/css" />
    <script src="../resources/js/jquery-3.7.1.js"></script>
<script>
let code = "";
$(document).ready(function() {
    validateNick();
    validateId();
    
    $("#nick").keyup(function() {
        validateNick();
        checkNick();
    });

    $("#id").keyup(function() {
        validateId();
    });

    $("form").submit(function() {
        if ($("#id").val().length < 4) {
            alert("아이디는 최소 4자 이상이어야 합니다.");
            $("#id").focus();
            return false;
        }
        if (!isIdChecked) {
            alert("아이디 중복체크를 해주세요");
            $("#id").focus();
            return false;
        }
        if (isIdDuplicated) {
            alert("사용할 수 없는 아이디입니다.");
            $("#id").focus();
            return false;
        }
        if ($("#nick").val() == "") {
            alert("닉네임을 입력해주세요");
            $("#nick").focus();
            return false;
        }
        if (isNickDuplicated) {
            alert("사용할 수 없는 닉네임입니다.");
            $("#nick").focus();
            return false;
        }
        if ($("#pw").val().length < 4) {
            alert("비밀번호는 최소 4자 이상이어야 합니다.");
            $("#pw").focus();
            return false;
        }
        if ($("#pwc").val() == "") {
            alert("비밀번호 확인을 입력해주세요");
            $("#pwc").focus();
            return false;
        }
        if ($("#pw").val() != $("#pwc").val()) {
            alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
            $("#pwc").focus();
            return false;
        }
        if ($("#name").val() == "") {
            alert("이름을 입력해주세요");
            $("#name").focus();
            return false;
        }
        if ($("#email").val() == "") {
            alert("이메일을 입력해주세요");
            $("#email").focus();
            return false;
        }
        if ($("#checkc").val() == "") {
            alert("인증코드가 입력되지 않았습니다.");
            $("#checkc").focus();
            return false;
        } 
        if ($("#checkc").val() != code) {
            alert("인증코드가 일치하지 않습니다.");
            $("#checkc").focus();
            return false;
        } 
		if(confirm("회원가입을 진행하시겠습니까?") == false)
		{
			return false;
		}
		return true;
    });
});

let isIdChecked = false;
let isIdDuplicated = false;
function validateId() {
    var id = $("#id").val();
    var idRegex = /^[a-z0-9]+$/;
    if (id.length < 4) {
        $("#msg_id").text("아이디는 최소 4자 이상이어야 합니다.").css("color", "red");
        isIdChecked = false;
    } else if (!idRegex.test(id)) {
        $("#msg_id").text("아이디는 숫자와 영어 소문자만 가능합니다").css("color", "red");
        isIdChecked = false;
    } else {
        $("#msg_id").text("");
        isIdChecked = true;
    }
}

let isNickDuplicated = false;
function validateNick() {
    var nick = $("#nick").val();
    if (nick === "") {
        $("#msg_nick").text("닉네임을 입력해주세요").css("color", "red");
        isNickDuplicated = false;
    } else {
        $("#msg_nick").text("");
    }
}

function checkId() {
    var contextPath = '<%=request.getContextPath()%>';
    $.ajax({
        url: contextPath + "/ajax/checkID.do",
        type: "get",
        data: {id: $("#id").val()},
        success: function(data) {
            if (data == '0') {
                alert("사용할 수 없는 아이디입니다.");
                $("#id").focus();
                isIdDuplicated = true;
            } else if (data == '1') {
                alert("사용할 수 있는 아이디입니다.");
                isIdDuplicated = false;
            }
        },
        error: function() {
            alert("예외 발생!");
        }
    });
}

function checkNick() {
    var contextPath = '<%=request.getContextPath()%>';
    $("#msg_nick").text("");
    if($("#nick").val() == "") {
        $("#msg_nick").text("닉네임을 입력해주세요").css("color", "red");
        return;
    }
    $.ajax({
        url: contextPath + "/ajax/checkNick.do",
        type: "get",
        data: {nick: $("#nick").val()},
        success: function(data) {
            if (data == '0') {
                $("#msg_nick").text("사용할 수 없는 닉네임입니다.").css("color", "red");
                isNickDuplicated = true;
            } else if (data == '1') {
                $("#msg_nick").text("사용할 수 있는 닉네임입니다.").css("color", "green");
                isNickDuplicated = false;
            }
        },
        error: function() {
            alert("예외 발생!");
        }
    });
}

function sendmail() {
    var contextPath = '<%=request.getContextPath()%>';
    var email = $("#email").val();
    if (email === "") {
        alert("이메일을 입력해주세요");
        return;
    }

    $.ajax({
        url: contextPath + "/sendmail.do",
        type: "get",
        data: { email: email },
        success: function(response) {
            if(response == "0") {
                alert("전송 실패");
            } else {    
                code = response;
                alert("이메일을 발송했습니다.\n인증 코드를 확인해주세요.");
            }
        },
        error: function() {
            alert("메일 발송 중 오류가 발생했습니다.");
        }
    });
}
</script>
</head>
<body>
    <section>
        <div class="login">
            <form name="login_box" action="join.do" method="post">
                <div class="logo">
                    <a href="<%= request.getContextPath() %>/user/login.do"><img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="메인로고"></a>
                </div>
                <div class="label">아이디 :</div>
                <input type="text" id="id" name="id"><button type="button" onclick="checkId()">중복확인</button>
                <span id="msg_id"></span>
                <div class="label">닉네임 :</div>
                <input type="text" id="nick" name="nick">
                <span id="msg_nick"></span>
                <div class="label">비밀번호 :</div>
                <input type="password" id="pw" name="pw">
                <div class="label">비밀번호 확인 :</div>
                <input type="password" id="pwc" name="pwc">
                <div class="label">이름 :</div>
                <input type="text" id="name" name="name">
                <div class="label">이메일 :</div>
                <input type="text" id="email" name="email"><button type="button" onclick="sendmail()">인증메일 전송</button>             
                <div class="label" style="margin-top: 5px">인증코드 :</div>
                <input type="text" id="checkc" name="checkc">
                <input type="submit" value="회원가입">
                <br>
                <div class="help">
                    <div>계정이 있으신가요? &nbsp; <a href="login.do">로그인</a></div>
                </div>
            </form> 
        </div>
    </section>
</body>
</html>
