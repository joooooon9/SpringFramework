<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<link href="../resources/css/random.css" rel="stylesheet" type="text/css" />
    <!-------------- 컨텐츠 출력부분 --------------->
<table style="width: 50%; margin-top: 30px;">
    <tr>
        <td>
            <div class="random">
                <canvas width="500" height='500'></canvas>  
                <button onclick="rotate();">룰렛 돌리기</button>
              </div>
              
        </td>
    </tr>
</table>
    <!-------------- 컨텐츠 출력부분 --------------->
<script src="<%= request.getContextPath() %>/resources/js/random.js"></script>    
<jsp:include page="../include/tail.jsp" flush="true"/>