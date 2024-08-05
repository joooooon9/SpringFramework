<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<link href="../resources/css/notice.css" rel="stylesheet" type="text/css" />

<!-------------- 컨텐츠 출력부분 --------------->
<table class="content-table">
    <tr style="text-align: center; background-color: darkgray;">
        <th style="width: 100px;">번호</th>
        <th>제목</th>
        <th style="width: 100px;">조회 수</th>
        <th style="width: 200px;">작성일</th>
    </tr>
    <c:forEach var="notice" items="${noticeList}">
        <tr style="text-align: center;">
            <td>${notice.notinum}</td>
            <td style="text-align: left;"><a href="notice_view.do?bno=${notice.notinum}">${notice.ntitle}</a></td>
            <td>${notice.nhit}</td>
            <td>${notice.nwdate}</td>
        </tr>
    </c:forEach>
    <c:if test="${sessionScope.login ne null && sessionScope.login.isadmin eq 'Y'}">
    <tr>
        <td colspan="4" style="text-align: right;">
            
                <input type="button" value="공지작성" onclick="location.href='notice_write.do'">
        </td>
    </tr>
    </c:if>
</table>
<!-------------- 컨텐츠 출력부분 --------------->
<jsp:include page="../include/tail.jsp" flush="true"/>