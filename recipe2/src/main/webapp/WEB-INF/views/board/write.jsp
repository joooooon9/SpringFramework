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
window.onload = function()
{
	//스마트에디터2 사용
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : oEditors,
		elPlaceHolder : "ingredient", //저는 textarea의 id와 똑같이 적어줬습니다.
		sSkinURI : "../resources/se2/SmartEditor2Skin.html", //경로를 꼭 맞춰주세요!
		fCreator : "createSEditor2",
		htParams : {
			// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseToolbar : true,

			// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,

			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : false
		}
	
	});
	//스마트에디터2 사용 2번째꺼
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : oEditors,
		elPlaceHolder : "content", //저는 textarea의 id와 똑같이 적어줬습니다.
		sSkinURI : "../resources/se2/SmartEditor2Skin.html", //경로를 꼭 맞춰주세요!
		fCreator : "createSEditor2",
		htParams : {
			// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseToolbar : true,

			// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,

			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : false
		}
	});
	
	//document.writeFrm.btitle.focus();
	$("#title").focus();
	
	$("#write").submit(function(){
		
		//스마트에디터 value 값 가져오기(포커스 잡기위함)
		oEditors.getById["ingredient"].exec("UPDATE_CONTENTS_FIELD", []);
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		//스마트에디터 안에 <br>태그 빈칸으로 바꿔주고 trim으로 공백제거
		console.log($("#ingredient").val().replace("<br>", "").trim() )
		console.log($("#content").val().replace("<br>", "").trim() )
		
		if($("#title").val() == "")
		{
			alert("레시피 제목을 입력하세요.");
			$("#title").focus();
			return false;
		}
		if($("#isshare").val() == "DS")
		{
			alert("공개여부를 설정해주세요.");
			$("#isshare").focus();
			return false;
		}
		if($("#subtitle").val() == "")
		{
			alert("레시피설명을 입력하세요.");
			$("#subtitle").focus();
			return false;
		}
		if($("#serving").val() == "")
		{
			alert("인원명을 입력하세요.");
			$("#serving").focus();
			return false;
		}
		if($("#cooktime").val() == "")
		{
			alert("조리시간을 입력하세요.");
			$("#cooktime").focus();
			return false;
		}
		//스마트에디터 안에 <br>태그 빈칸으로 바꿔주고 trim으로 공백제거 한것을 if문으로 검사
		if($("#ingredient").val().replace("<br>", "").trim() == "")
		{
			alert("재료를 입력하세요.");
			//$("#re_mat").focus();
			//스마트에디터 포커스 잡는법
			oEditors.getById["ingredient"].exec("FOCUS")
			return false;
		}
		//스마트에디터 안에 <br>태그 빈칸으로 바꿔주고 trim으로 공백제거 한것을 if문으로 검사
		if($("#content").val().replace("<br>", "").trim() == "")
		{
			alert("조리방법을 입력하세요.");
			//$("#re_way").focus();
			//스마트에디터 포커스 잡는법
			oEditors.getById["content"].exec("FOCUS")
			return false;
		}
		if(confirm("게시물을 저장하시겠습니까?") == false)
		{
			return false;
		}
		return true;
	});
	//이미지미리보기
	$(function(){
		$("#attach").change(function(event){
			const file = event.target.files;

			var image = new Image();
			var ImageTempUrl = window.URL.createObjectURL(file[0]);
			    
            image.src = ImageTempUrl;
            image.className = "profile-image";
			
			$("#recipeimg img").remove();
			$("#recipeimg").append(image);
		});
	});
}
</script>
<form id="write" action="${pageContext.request.contextPath}/board/writeok.do" method="post" enctype="multipart/form-data">
<table class="content-table">
    <tr>
        <td colspan="2">레시피 이름 :</td>
    </tr>
    <tr>
        <td colspan="2"><input type="text" id="title" name="title" class="input-large"></td>
    </tr>
    <tr>
        <td>공개여부 : 
            <select name="isshare" id="isshare">
            	<option value="DS">공개여부</option>
                <option value="M">나만보기</option>
                <option value="S">공개레시피</option>
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="2">레시피설명 :</td>
    </tr>
    <tr>
        <td colspan="2"><input type="text" id="subtitle" name="subtitle" class="input-large"></td>
    </tr>
    <tr>
        <td colspan="2">메인사진
        <div id="recipeimg"></div>
        <br><input type="file" id="attach" name="attach">
        </td>
    </tr>
    <tr>
        <td>인원 : <input type="text" id="serving" name="serving" class="input-small">(명)</td>
        <td>소요 시간 : <input type="text" id="cooktime" name="cooktime" class="input-small">(분)</td>
    </tr>
    <tr>
        <td colspan="2">재료 :</td>
    </tr>
    <tr>
        <td colspan="2"><textarea id="ingredient" name="ingredient" style="width: 100%; height: 400px;"></textarea></td>
    </tr>
    <tr>
        <td colspan="2">조리 방법 :<br><span style="color: red; font-size: 20px;">*조리순서대로 작성하시면 관리하기 편합니다</span></td>
    </tr>
    <tr>
        <td colspan="2"><textarea id="content" name="content" style="width: 100%; height: 400px;"></textarea></td>
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