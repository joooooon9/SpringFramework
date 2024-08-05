<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<link href="../resources/css/view.css" rel="stylesheet" type="text/css" />

<script src="../resources/js/jquery-3.7.1.js"></script>
<script>
$(document).ready(function() {
    loadReplies();
    $('#addReplyButton').click(function(event) {
        event.preventDefault(); // 폼 제출을 막음
        addReply();
    });
});

function DoDelete(bno) {
    if (confirm("해당 게시물을 삭제하시겠습니까?") == false) {
        return;
    }
    document.location = "delete.do?bno=" + bno;
}

function loadReplies() {
    var bno = "${bvo.bno}";
    var loginUserNo = "${loginUser.userno}"; // 로그인한 사용자 userno
    $.ajax({
        url: "${pageContext.request.contextPath}/board/getReplies.do",
        type: "GET",
        data: { bno: bno },
        success: function(data) {
            var replies = '';
            data.forEach(function(reply) {
                var date = new Date(reply.rdate);
                var formattedDate = date.getFullYear() + '-' + ('0' + (date.getMonth() + 1)).slice(-2) + '-' + ('0' + date.getDate()).slice(-2);
                replies += '<tr>';
                replies += '<td rowspan="2" style="width: 50px;">';
                replies += '<img src="${pageContext.request.contextPath}/resources/profile/' + reply.bpname + '" alt="" style="width: 120px; height: 120px;">';
                replies += '</td>';
                replies += '<td colspan="3" style="font-weight: bold; width: 90%;">';
                replies += reply.nick + ' &nbsp; <span style="font-weight: normal; font-size: 10pt;">' + formattedDate + '</span> &nbsp; ';
                for (var i = 0; i < reply.score; i++) {
                    replies += '★';
                }
                for (var j = reply.score; j < 5; j++) {
                    replies += '☆';
                }
                replies += '</td>';
                replies += '<td>';
                replies += '<button type="button"><img src="${pageContext.request.contextPath}/resources/img/신고.png" alt="" style="width: 20px; height: 20px;" onclick="confirm(\'이 댓글을 신고하시겠습니까?\')"></button>';
                replies += '</td>';
                replies += '</tr>';
                replies += '<tr>';
                replies += '<td colspan="3">' + reply.rnote + ' <br><br><br><hr></td>';
                // 댓글 작성자와 로그인한 사용자가 같으면 삭제 버튼 추가
                if (reply.userno === loginUserNo) {
                    replies += '<td><button type="button" class="delbtn" data-rno="' + reply.rno + '">삭제</button></td>';
                } else {
                    replies += '<td></td>';
                }
                replies += '</tr>';
            });
            $('#replyTable').html(replies);

            // 삭제 버튼에 이벤트 핸들러 추가
            $('.delbtn').click(function() {
                var rno = $(this).data('rno');
                deleteReply(rno);
            });
        },
        error: function() {
            alert("댓글을 불러오는 데 실패했습니다.");
        }
    });
}

function addReply() {
    var bno = "${bvo.bno}";
    var userno = "${loginUser.userno}";
    var rnote = $('#rnote').val();
    var score = $('#score').val();

    $.ajax({
        url: "${pageContext.request.contextPath}/board/addReply.do",
        type: "POST",
        data: {
            bno: bno,
            userno: userno,
            rnote: rnote,
            score: score
        },
        success: function() {
            alert("댓글이 등록되었습니다.");
            loadReplies();
        },
        error: function() {
            alert("댓글을 등록하는 데 실패했습니다.");
        }
    });
}

function deleteReply(rno) {
    if (!confirm("해당 요리후기를 삭제하시겠습니까?")) {
        return;
    }

    $.ajax({
        url: "${pageContext.request.contextPath}/board/deleteReply.do",
        type: "POST",
        data: { rno: rno },
        success: function() {
            alert("요리후기가 삭제되었습니다.");
            loadReplies();
        },
        error: function() {
            alert("요리후기를 삭제하는 데 실패했습니다.");
        }
    });
}



//추가된 부분 isshare 구분 목록가기
function goToList() {
    var isshare = "${bvo.isshare}";
    if (isshare === 'S') {
        location.href = 'share.do';
    } else {
        location.href = 'index.do';
    }
}


</script>

<form id="view">
    <table class="content-table">
        <tr>
            <td colspan="2" style="font-size: 20pt; font-weight: bold; width: 150px;">
                레시피 이름 : <span style="font-size: 18pt; font-weight: normal;">${bvo.title}</span>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="font-size: 20pt; font-weight: bold;">
                레시피설명 : <span style="font-size: 18pt; font-weight: normal;">${bvo.subtitle}</span>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <c:choose>
                    <c:when test="${not empty bvo.fileVO.bfname}">
                        <img src="${pageContext.request.contextPath}/resources/upload/${bvo.fileVO.bpname}" style="width: 100%; height: 300px;"/>
                    </c:when>
                    <c:otherwise>
                        <img src="<c:url value='/resources/img/recipelogo.png' />" style="width: 100%; height: 300px;">
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <td style="font-size: 20pt; font-weight: bold;">인원 : ${bvo.serving}(명)</td>
            <td style="font-size: 20pt; font-weight: bold;">소요 시간 : ${bvo.cooktime}(분)</td>
        </tr>
        <tr>
            <td colspan="2" style="font-size: 20pt; font-weight: bold;">재료 :</td>
        </tr>
        <tr>
            <td colspan="2">
                <div><c:out value="${bvo.ingredient}" escapeXml="false"/></div>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="font-size: 20pt; font-weight: bold;">조리 방법 :</td>
        </tr>
        <tr>
            <td colspan="2">
                <div><c:out value="${bvo.content}" escapeXml="false"/></div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="button-container">
                    <input type="button" value="레시피 목록" onclick="goToList()">&nbsp;
                    <c:if test="${loginUser != null && loginUser.isadmin == 'Y'}">
                    	<input type="button" value="레시피 수정" onclick="location.href='modify.do?no=${bvo.bno}'">&nbsp;
                   	</c:if>
                    <c:if test="${loginUser != null && loginUser.userno == bvo.userno}">
                        <input type="button" value="레시피 수정" onclick="location.href='modify.do?no=${bvo.bno}'">&nbsp;
                        <input type="button" id="delete" value="레시피 삭제" onclick="DoDelete('${bvo.bno}')">
                    </c:if>
                </div>
            </td>
        </tr>
    </table>
</form>

<c:if test="${isShared}">
    <!---------------- 요리 후기 입력과 리스트 시작 -------------------->
    <table class="review-table"  >
        <tr>
            <td style="width: 70px; padding: 0; padding-left: 10px;">평점 : 
                <select id="score">
                    <option value="5">★★★★★</option>
                    <option value="4">★★★★☆</option>
                    <option value="3">★★★☆☆</option>
                    <option value="2">★★☆☆☆</option>
                    <option value="1">★☆☆☆☆</option>
                </select>
            </td>
        </tr>
        <tr>
            <td colspan="4">요리 후기 :</td>
        </tr>
        <tr>
            <td colspan="4" style="width: 100px;">
                <h2><img src="${pageContext.request.contextPath}/resources/profile/${ login.bpname }" alt="" style="width: 30px; height: 30px;">
                    ${loginUser.nick} &nbsp; <span style="font-weight: normal; font-size: 10pt;"></span>
                </h2>
            </td>
        </tr>
        <tr>
            <td colspan="4" style="width: 80%;"><textarea id="rnote"></textarea></td>
            <td style="vertical-align: middle; text-align: center; width: 120px;">
                <input type="submit" id="addReplyButton" value="후기 남기기">
            </td>
        </tr>
        <tbody id="replyTable">
            <!-- 댓글 목록이 여기 들어갑니다(시작). -->
            
            <!-- 댓글 목록이 여기 들어갑니다(끝). -->
        </tbody>
    </table>
    <!---------------- 요리 후기 입력과 리스트 끝 -------------------->
</c:if>

<jsp:include page="../include/tail.jsp" flush="true"/>
