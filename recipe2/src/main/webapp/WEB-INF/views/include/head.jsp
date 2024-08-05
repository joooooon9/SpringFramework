<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="../resources/css/index.css" rel="stylesheet" type="text/css" />
    <script src="../resources/js/jquery-3.7.1.js"></script>
    <title>오늘 뭐먹지?</title>
    <script>
    	console.log("${ login.bpname }");
    </script>
</head>
<body>
    <div class="content-wrapper">
        <table border="0">
            <tr>
                <td>
                    <div class="logo">
                        <a href="<%= request.getContextPath() %>/board/index.do"><img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="메인로고"></a>
                        <div class="user">
                            <img src="${pageContext.request.contextPath}/resources/profile/${ login.bpname }" alt="" style="width: 30px;">
                            ${ login.nick }
                            <div class="dropdown-content">
                                <a href="<%= request.getContextPath() %>/user/mypage.do">마이페이지</a>
                                <a href="<%= request.getContextPath() %>/user/logout.do">로그아웃</a>
                            </div>
                        </div>
                    </div>
                    <div>
                        <nav class="menu">
                            <a href="<%= request.getContextPath() %>/board/index.do">나의레시피</a>
                            <a href="<%= request.getContextPath() %>/board/share.do">공개레시피</a>
                            <a href="<%= request.getContextPath() %>/board/random.do">랜덤메뉴</a>
                            <a href="<%= request.getContextPath() %>/board/notice.do">공지사항</a>
                        </nav>
                    </div>
                </td>
            </tr>
            <tr>
                <td>