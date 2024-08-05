<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<link href="../resources/css/write.css" rel="stylesheet" type="text/css" />
<script src="../resources/se2/js/HuskyEZCreator.js"></script>
<script src="../resources/js/jquery-3.7.1.js"></script>
<!-------------- 컨텐츠 출력부분 --------------->
<style>
.profile-image 
{
	width: 100%;  
	height: 300px; 
}	
</style>
<script>
window.onload = function() {
    //스마트에디터2 사용
    var oEditors = [];
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "ncontent", //저는 textarea의 id와 똑같이 적어줬습니다.
        sSkinURI: "../resources/se2/SmartEditor2Skin.html", //경로를 꼭 맞춰주세요!
        fCreator: "createSEditor2",
        htParams: {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar: true,

            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer: true,

            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger: false
        }
    });

    //document.writeFrm.btitle.focus();
    $("#ntitle").focus();

    $("#write").submit(function() {
        oEditors.getById["ncontent"].exec("UPDATE_CONTENTS_FIELD", []);
        //스마트에디터 안에 <br>태그 빈칸으로 바꿔주고 trim으로 공백제거
        let content = $("#ncontent").val().replace(/<br>/gi, "").replace(/&nbsp;/gi, "").trim();

        if ($("#ntitle").val() == "") {
            alert("제목을 입력하세요.");
            $("#ntitle").focus();
            return false;
        }

        // <p>, <div>, <br> 태그와 공백 문자만 남아있는지 검사
        if (content == "" || content == "<p></p>" || content == "<p><br></p>" || content == "<p>&nbsp;</p>") {
            alert("내용을 입력하세요.");
            //스마트에디터 포커스 잡는법
            oEditors.getById["ncontent"].exec("FOCUS");
            return false;
        }

        if (confirm("게시물을 저장하시겠습니까?") == false) {
            return false;
        }
        return true;
    });
}
</script>
<form id="write" action="${pageContext.request.contextPath}/board/notice_writeOK.do" method="post" enctype="multipart/form-data">
<table class="content-table">
    <tr>
        <td colspan="2">제목 :</td>
    </tr>
    <tr>
        <td colspan="2"><input type="text" id="ntitle" name="ntitle" class="input-large"></td>
    </tr>
    <tr>
        <td colspan="2">내용 :</td>
    </tr>
    <tr>
        <td colspan="2"><textarea id="ncontent" name="ncontent" style="width: 100%; height: 400px;"></textarea></td>
    </tr>
    <tr>
        <td colspan="2">
            <div class="button-container">
                <input type="submit" id="write_btn" value="작성완료">&nbsp;<input type="button" value="돌아가기" onclick="location.href='index.do'">
            </div>
        </td>
    </tr>
</table>
</form>
<!---------------- 콘텐츠 출력 끝 -------------------->
<jsp:include page="../include/tail.jsp" flush="true"/>