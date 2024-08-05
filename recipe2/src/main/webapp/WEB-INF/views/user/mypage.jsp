<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<link href="../resources/css/mypage.css" rel="stylesheet" type="text/css" />
<!-------------- 컨텐츠 출력부분 --------------->
<script>
let originalNick = '${ login.nick }';
let isNickChecked = false;
let isNickDuplicated = false;

$(document).ready(function() {
    $("#nick").keyup(function() {
        isNickChecked = false; // 닉네임이 변경되면 다시 중복체크를 해야 함
    });

    $("form").submit(function(event) {
        if ($("#nick").val() != originalNick && !isNickChecked && "") {
            alert("닉네임 중복체크를 해주세요");
            $("#nick").focus();
            return false;
        }
        if (isNickDuplicated) {
            alert("사용할 수 없는 닉네임입니다.");
            $("#nick").focus();
            return false;
        }else if($("#nick").val() == "")
       	{
        	alert("닉네임을 입력해주세요.")
        	$("#nick").val();
        	$("#nick").focus();
        	return false;
       	}
        if (confirm("변경된 사항을 저장하시겠습니까?\n로그인 화면으로 이동됩니다.")) {
        	console.log("로그인 화면으로 이동");
        	console.log("url : " + $(this).attr('action'));
            var formData = new FormData(this);
            $.ajax({
                url: $(this).attr('action'),
                type: 'POST',
                data: formData,
                contentType: false,
                processData: false,
                success: function(result) {
               		console.log(result);
                	if(result == "ok") 
                	{
                		console.log("success");
	                    window.location.href = '<%=request.getContextPath()%>/user/logout.do';
                	}else{
                	}
                },
                error: function() {
                    alert("정보 저장에 실패했습니다. 다시 시도해주세요.");
                }
            });
        } else {
            return false;
        }
    });
});

function checkNick() {
    var contextPath = '<%=request.getContextPath()%>';
    $.ajax({
        url: contextPath + "/ajax/checkNick.do",
        type: "get",
        data: {nick: $("#nick").val()},
        success: function(data) {
            if (data == '0') {
                alert("사용할 수 없는 닉네임입니다.");
                $("#nick").focus();
                isNickDuplicated = true;
            } else if (data == '1') {
                alert("사용할 수 있는 닉네임입니다.");
                isNickDuplicated = false;
                isNickChecked = true;
            }
        },
        error: function() {
            alert("예외 발생!");
        }
    });
}

$(function() {
    $("#imgFile").change(function(event) {
        const file = event.target.files;
        var image = new Image();
        var ImageTempUrl = window.URL.createObjectURL(file[0]);

        image.width = 150; 
        image.height = 130; 
        image.src = ImageTempUrl;

        $("#profileimg img").remove();
        $("#profileimg").append(image);
    });
});
</script>
<form id="form" action="mypageok.do" method="post" enctype="multipart/form-data">
<table border="0" style="padding-top: 30px; width: 550px; height: 500px; margin: 120px auto; background-color: darkgrey; border-radius: 5px;">
    <tr>
        <td colspan="2" style="height: 100px;">
            <div id="profileimg" style="width: 150px;">
                <label for="imgFile">
                    <img src="${pageContext.request.contextPath}/resources/profile/${ login.bpname }" style="width: 150px; height: 130px;">
                </label>
            </div><br>
            <input type="file" name="imgFile" id="imgFile" accept=".jpg, .png" class="form-control">
        </td>
    </tr>
    <tr>
        <td style="text-align: center;">&nbsp;아이디</td>
        <td>${ login.id }</td>
    </tr>
    <tr>
        <td style="text-align: center;">&nbsp;이름</td>
        <td>${ login.name }</td>
    </tr>
    <tr>
        <td style="text-align: center; width: 120px;">&nbsp;닉네임</td>
        <td><input type="text" id="nick" name="nick" value="${ login.nick }"><input type="button" value="중복확인" onclick="checkNick()"></td>
    </tr>
    <tr>
        <td style="text-align: center;">&nbsp;이메일</td>
        <td>${ login.email }</td>
    </tr>
    <tr>
        <td colspan="2" style="text-align: center;">
            <div>
                <input type="submit" value="적용">
                <input type="button" onclick="location.href='newPw.do?id=${login.id}'" value="비밀번호 변경"><br>
            </div>
         </td>
    </tr>
</table>
</form>
<!---------------- 콘텐츠 출력 끝 -------------------->
<jsp:include page="../include/tail.jsp" flush="true"/>
