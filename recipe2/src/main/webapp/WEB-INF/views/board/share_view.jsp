<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/head.jsp" flush="true"/>
<link href="../resources/css/sview.css" rel="stylesheet" type="text/css" />
<!-------------- 컨텐츠 출력부분 --------------->
<table class="content-table">
    <tr>
        <td colspan="2" style="font-size: 20pt; font-weight: bold; width: 150px;">레시피 이름 : <span style="font-size: 18pt; font-weight: normal;">김치찌개</span></td>
    </tr>
    <tr>
        <td colspan="2" style="font-size: 20pt; font-weight: bold;">레시피설명 : <span style="font-size: 18pt; font-weight: normal;">백종원 김치찌개 업그레이드 버전</span></td>
    </tr>
    <tr>
        <td colspan="2"><img src="../resources\img\김치찌개.jpg" width="100%" height="300px;"></td>
    </tr>
    <tr>
        <td style="font-size: 20pt; font-weight: bold;">인원 : 1(명)</td>
        <td style="font-size: 20pt; font-weight: bold;">소요 시간 : 10(분)</td>
    </tr>
    <tr>
        <td colspan="2" style="font-size: 20pt; font-weight: bold;">재료 :</td>
    </tr>
    <tr>
        <td colspan="2"><textarea readonly>묵은지 1/4포기 , 쌀뜨물 4컵 , 청양고추 1개 , 고춧가루 2큰술, 국간장 1큰술, 돼지고기 150g , 된장 0.5큰술, 다진마늘 1큰술</textarea></td>
    </tr>
    <tr>
        <td colspan="2" style="font-size: 20pt; font-weight: bold;">조리 방법 :<br><span style="color: red; font-size: 20px;">*조리순서대로 작성하시면 관리하기 편합니다</span></td>
    </tr>
    <tr>
        <td colspan="2"><textarea readonly style="height: 400px;">1.먼저 속을 털어낸 묵은지 1/4포기를 잘게 썰어서 준비, 돼지고기도 한 컵 준비 그리고 대파와 청양고추도 송송 썰어 준비   ++ 김치와 돼지고기의 비율은 3 :1 ++

2.냄비에 쌀뜨물 4컵과 돼지고기 1컵을 넣고 김치찌개의 깊은 맛과 돼지고기의 잡내 제거를 위해 된장도 반 큰 술도 넣는다. 그리고 쌀뜨물이 끓으면서 떠오르는 불순물과 거품은 모두 건져낸다.
            
3.돼지기름이 국물에 충분히 우러나온 것 같다 싶으면 잘게 썰어둔 묵은지를 투척-
            
4.고춧가루 2 큰 술과 다진 마늘 1 큰 술, 국간장 1 큰 술을 넣고 간은 새우젓으로!
            
5.맛이 2%가 부족한 것 같다면 김치 국물을 3-4 큰 술 넣어주셔도 좋아요. 어슷 썬 청양고추 1 개도 넣고 팽이버섯도 조금 넣는다.
            
6.마지막으로 대파까지 올려주면  7분 김치찌개 만드는 법, 끝!</textarea></td>
    </tr>
    <tr>
        <td colspan="2" style="text-align: end;">
            <button type="button">
                <img src="../resources/img/신고.png" alt="" style="width: 20px; height: 20px;">
            </button>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <div class="button-container">
                <input type="button" value="레시피 목록" onclick="location.href='share.do'">&nbsp;<input type="button" value="레시피 수정" onclick="location.href='modify.do'">&nbsp;<input type="submit" value="레시피 삭제">
            </div>
        </td>
    </tr>
</table>
<!---------------- 요리 후기 입력 시작 -------------------->
<table class="review-table">
    <tr>
        <td style="width: 70px; padding: 0; padding-left: 10px;">평점 : 
            <select>
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
        <td colspan="3" style="width: 95%;"><textarea></textarea></td>
        <td style="vertical-align: middle; text-align: center; width: 120px;">
            <input type="submit" value="후기 남기기">
        </td>
    </tr>
    <tr>
        <td rowspan="2" style="width: 50px;"><img src="../resources/img/user.png" alt="" style="width: 30px; height: 30px;"></td>
        <td style="font-weight: bold; width: 90%;">천종원 &nbsp; <span style="font-weight: normal; font-size: 10pt;">2024.06.28</span> &nbsp; ★★★★★ &nbsp; </td>
        <td>      
	        <button type="button">
                <img src="../resources/img/신고.png" alt="" style="width: 20px; height: 20px;" onclick="confirm('이 댓글을 신고하시겠습니까?')">
            </button>      
        </td>
    </tr>
    <tr>
        <td>맛있게 잘해먹었습니다.<hr></td>
    </tr>
</table>
<!---------------- 요리 후기 입력 끝 -------------------->
<!---------------- 콘텐츠 출력 끝 -------------------->
<jsp:include page="../include/tail.jsp" flush="true"/>