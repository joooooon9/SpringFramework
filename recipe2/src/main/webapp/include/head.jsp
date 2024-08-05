<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="resources/css/index.css" rel="stylesheet" type="text/css" />
    <script src="resources/js/jquery-3.7.1.js"></script>
    <title>나의 레시피</title>
</head>
<body>
    <div class="content-wrapper">
        <table border="0">
            <tr>
                <td>
                    <div class="logo">
                        <a href="index.jsp"><img src="resources/img/logo.png" alt="메인로고"></a>
                        <div class="user">
                            <img src="resources/img/user.png" alt="" style="width: 30px;">
                            자취마스터
                            <div class="dropdown-content">
                                <a href="mypage.jsp">마이페이지</a>
                                <a href="logout.jsp">로그아웃</a>
                            </div>
                        </div>
                    </div>
                    <div>
                        <nav class="menu">
                            <a href="index.jsp">나의레시피</a>
                            <a href="share.jsp">공개레시피</a>
                            <a href="random.jsp">랜덤메뉴</a>
                            <a href="notice.jsp">공지사항</a>
                        </nav>
                    </div>
                </td>
            </tr>
            <tr>
                <td>