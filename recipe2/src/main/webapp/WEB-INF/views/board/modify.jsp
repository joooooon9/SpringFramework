<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<link href="../resources/css/modify.css" rel="stylesheet" type="text/css" />
<script src="../resources/se2/js/HuskyEZCreator.js"></script>
<script src="../resources/js/jquery-3.7.1.js"></script>

<script>
window.onload = function() {
    var oEditors = [];
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "ingredient",
        sSkinURI: "../resources/se2/SmartEditor2Skin.html",
        fCreator: "createSEditor2",
        htParams: {
            bUseToolbar: true,
            bUseVerticalResizer: false,
            bUseModeChanger: false
        }
    });
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "content",
        sSkinURI: "../resources/se2/SmartEditor2Skin.html",
        fCreator: "createSEditor2",
        htParams: {
            bUseToolbar: true,
            bUseVerticalResizer: false,
            bUseModeChanger: false
        }
    });

    $("#title").focus();

    $("#modify").submit(function() {
        oEditors.getById["ingredient"].exec("UPDATE_CONTENTS_FIELD", []);
        oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
        
        if ($("#title").val() == "") {
            alert("레시피 제목을 입력하세요.");
            $("#title").focus();
            return false;
        }
        if ($("#isshare").val() == "DS") {
            alert("공개여부를 설정해주세요.");
            $("#isshare").focus();
            return false;
        }
        if ($("#subtitle").val() == "") {
            alert("레시피설명을 입력하세요.");
            $("#subtitle").focus();
            return false;
        }
        if ($("#serving").val() == "") {
            alert("인원명을 입력하세요.");
            $("#serving").focus();
            return false;
        }
        if ($("#cooktime").val() == "") {
            alert("조리시간을 입력하세요.");
            $("#cooktime").focus();
            return false;
        }
        if ($("#ingredient").val().replace("<br>", "").trim() == "") {
            alert("재료를 입력하세요.");
            oEditors.getById["ingredient"].exec("FOCUS");
            return false;
        }
        if ($("#content").val().replace("<br>", "").trim() == "") {
            alert("조리방법을 입력하세요.");
            oEditors.getById["content"].exec("FOCUS");
            return false;
        }
        if (confirm("게시물을 저장하시겠습니까?") == false) {
            return false;
        }
        return true;
    });
}
</script>

<form id="modify" action="modifyOK.do" method="post" enctype="multipart/form-data">
    <input type="hidden" name="bno" value="${bvo.bno}">
    <table class="content-table">
        <tr>
            <td colspan="2">레시피 이름 :</td>
        </tr>
        <tr>
            <td colspan="2"><input type="text" id="title" name="title" class="input-large" value="${bvo.title}"></td>
        </tr>
        <tr>
            <td>공개여부 : 
                <select name="isshare" id="isshare">
                    <option value="DS">공개여부</option>
                    <option value="M" ${bvo.isshare == 'M' ? 'selected' : ''}>나만보기</option>
                    <option value="S" ${bvo.isshare == 'S' ? 'selected' : ''}>공개레시피</option>
                </select>
            </td>
        </tr>
        <tr>
            <td colspan="2">레시피설명 :</td>
        </tr>
        <tr>
            <td colspan="2"><input type="text" id="subtitle" name="subtitle" class="input-large" value="${bvo.subtitle}"></td>
        </tr>
        <tr>
            <td colspan="2">
                <!-- 이미지 표시 -->
                <img src="${pageContext.request.contextPath}/resources/upload/${file.bpname}" alt="이미지" width="100%" height="300px">
                <!-- 파일 업로드 필드 -->
                <input type="file" style="width: 99%;" id="attach" name="attach">
            </td>
        </tr>
        <tr>
            <td>인원 : <input type="text" id="serving" name="serving" class="input-small" value="${bvo.serving}">(명)</td>
            <td>소요 시간 : <input type="text" id="cooktime" name="cooktime" class="input-small" value="${bvo.cooktime}">(분)</td>
        </tr>
        <tr>
            <td colspan="2">재료 :</td>
        </tr>
        <tr>
            <td colspan="2"><textarea id="ingredient" name="ingredient" style="width: 100%; height: 400px;">${bvo.ingredient}</textarea></td>
        </tr>
        <tr>
            <td colspan="2">조리 방법 :<br><span style="color: red; font-size: 20px;">*조리순서대로 작성하시면 관리하기 편합니다</span></td>
        </tr>
        <tr>
            <td colspan="2"><textarea id="content" name="content" style="width: 100%; height: 400px;">${bvo.content}</textarea></td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="button-container">
                    <input type="submit" value="수정완료">&nbsp;
                    <input type="button" value="돌아가기" onclick="location.href='view.do?bno=${bvo.bno}'">
                </div>
            </td>
        </tr>
    </table>
</form>

<jsp:include page="../include/tail.jsp" flush="true"/>