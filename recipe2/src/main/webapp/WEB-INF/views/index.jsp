<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="include/head.jsp" flush="true"/>
<!-------------- 컨텐츠 출력부분 --------------->
<table style="padding-top: 30px; width: 80%;">
    <tr class="maincon">
        <td>
            <div class="main">
                나만의 레시피를 기록해보세요! <input type="button" value="레시피작성"
                    onclick="location.href='write.do'">
            </div>
        </td>
    </tr>
    <c:forEach var="item" items="${boardList}">
        <tr class="maincon">
            <td>
                <div class="bwdate">${item.wdate}</div>
            </td>
        </tr>
        <tr class="maincon">
            <td>
                <div class="recipe-img-container">
                    <a href="${pageContext.request.contextPath}/board/view.do?bno=${item.bno}">
                    	<c:choose>
            				<c:when test="${not empty item.fileVO.bfname}">
            					<img src="${pageContext.request.contextPath}/resources/upload/${item.fileVO.bpname}" width="100%" height="300px" />
            				</c:when>
            				<c:otherwise>
            					<img src="<c:url value="/resources/img/recipelogo.png" />" width="100%" height="300px" >
            				</c:otherwise>
            			</c:choose>
                    </a>
                </div>
            </td>
        </tr>
        <tr class="maincon">
            <td class="mtitle">${item.title}
                <c:if test="${item.isshare == 'S'}">
                    <span style="color: red;">공개레시피</span>
                </c:if>
            </td>
        </tr>
    </c:forEach>
</table>
<!---------------- 콘텐츠 출력 끝 -------------------->
<jsp:include page="include/tail.jsp" flush="true"/>