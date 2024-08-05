<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<link href="../resources/css/notice_view.css" rel="stylesheet" type="text/css" />
            <!-------------- 컨텐츠 출력부분 --------------->
            <script>
            console.log("${nvo}")
            
            </script>
<table class="content-table">
    <tr style="text-align: left;">
        <td colspan="2"><h3>${nvo.ntitle}</h3></td>
    </tr>
    <tr>
        <td style="width: 150px;">조회 수 : ${nvo.nhit}</td>
        <td>| 작성일 : ${nvo.nwdate }</td>
    </tr>
    <tr>
        <td colspan="2"><hr></td>
    </tr>
    <tr>
        <td colspan="2"><div><c:out value="${nvo.ncontent}" escapeXml="false"/></div></td>
    </tr>
    <tr>
        <td colspan="2">
            <div class="button-container">
                <input type="button" value="목록으로" onclick="location.href='notice.do'">
            </div>
        </td>
    </tr>
</table>
            <!-------------- 컨텐츠 출력부분 --------------->
<jsp:include page="../include/tail.jsp" flush="true"/>