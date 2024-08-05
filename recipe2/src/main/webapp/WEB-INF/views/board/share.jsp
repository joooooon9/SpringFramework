<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<link href="../resources/css/share.css" rel="stylesheet" type="text/css" />

<!-- 레시피 출력 부분 -->
<div class="content-wrapper">
    <table id="recipeTable" style="padding-top: 30px; width: 80%;">
        <c:forEach var="board" items="${publicBoardList}" varStatus="status">
            <c:if test="${status.index % 2 == 0}">
                <tr class="maincon">
            </c:if>
            <td class="share_td">
                <div class="bwdate">${board.wdate}</div>
                <div class="recipe-img-container">
                    <a href="${pageContext.request.contextPath}/board/view.do?bno=${board.bno}">
                        <c:if test="${board.fileVO != null}">
                            <img src="${pageContext.request.contextPath}/resources/upload/${board.fileVO.bpname}" class="recipe-img" alt="${board.title}">
                        </c:if>
                        <c:if test="${board.fileVO == null}">
                            <img src="${pageContext.request.contextPath}/resources/img/recipelogo.png" class="recipe-img" alt="default">
                        </c:if>
                    </a>
                </div>
                <div class="mtitle">
                    ${board.title}<br>
                    ${board.user.nick}<span>조회수: (${board.bhit}) | 댓글수: (${board.rcount})</span>
                </div>
            </td>
            <c:if test="${status.index % 2 == 1}">
                </tr>
            </c:if>
        </c:forEach>
    </table>
    <!-- 더보기 버튼 -->
    <div class="more-button-container">
        <input type="button" id="more" name="more" value="더보기" onclick="loadMore()">
    </div>
</div>

<jsp:include page="../include/tail.jsp" flush="true"/>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    let offset = 6;
    const limit = 6;

    function loadMore() {
        $.ajax({
            url: '${pageContext.request.contextPath}/ajax/loadMore.do',
            type: 'GET',
            data: {
                offset: offset,
                limit: limit
            },
            dataType: 'json',
            success: function(data) {
                console.log(data);
                if (data.length > 0) {
                    let rows = '';
                    data.forEach(function(board, index) {
                        if (index % 2 === 0) {
                            rows += '<tr class="maincon">';
                        }
                        rows += '<td class="share_td">';
                        rows += '<div class="bwdate">' + board.wdate + '</div>';
                        rows += '<div class="recipe-img-container">';
                        rows += '<a href="' + '${pageContext.request.contextPath}/board/view.do?bno=' + board.bno + '">';
                        if (board.fileVO) {
                            rows += '<img src="' + '${pageContext.request.contextPath}/resources/upload/' + board.fileVO.bpname + '" class="recipe-img" alt="' + board.title + '">';
                        } else {
                            rows += '<img src="' + '${pageContext.request.contextPath}/resources/img/recipelogo.png' + '" class="recipe-img" alt="default">';
                        }
                        rows += '</a>';
                        rows += '</div>';
                        rows += '<div class="mtitle">';
                        rows += board.title + '<br>'+ board.user.nick;
                        rows += '<span>조회수: ('+ board.bhit + ') | 댓글수: ('+ board.rcount + ')</span>';
                        rows += '</div>';
                        rows += '</td>';
                        if (index % 2 === 1) {
                            rows += '</tr>';
                        }
                    });
                    $('#recipeTable').append(rows);
                    offset += limit;
                } else {
                    $('#more').prop('disabled', true).val('더 이상 게시물이 없습니다');
                }
            },
            error: function(request, status, error) {
                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });
    }
</script>