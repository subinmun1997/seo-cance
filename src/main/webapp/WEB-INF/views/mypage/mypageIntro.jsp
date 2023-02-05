<%--
  Created by IntelliJ IDEA.
  User: 문수빈
  Date: 2023-02-05
  Time: 14:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>미니프로필</title>
    <script>
        window.onload = function () {
            if(${member != null}){
                document.getElementById('header-miniprofileBox__guest').style.display = "none";
                document.getElementById('header-miniprofileBox').style.display = "block";
            }else{
                document.getElementById('header-miniprofileBox__guest').style.display = "block";
                document.getElementById('header-miniprofileBox').style.display = "none";
            }
        }
    </script>
</head>
<body>
<!--미니프로필-->
<div id="header-miniprofile">

    <!--로그인 후 화면-->
    <div id="header-miniprofileBox">
        <div id="header-miniprofile__photo">
            <img src="${pageContext.request.contextPath}/_image/profile/${member.member_img}">
        </div>
        <div id="header-miniprofile__info">
            <span style="color:#37FFEB;" id="header-miniprofile__span--nickname">${member.nickname}</span><span id="header-miniprofile__span--white">님</span>
            <br/>
            안녕하세요
        </div>

        <%-- 버튼 박스 : 로그아웃, 마이 페이지 --%>
        <div id="header-miniprofile__button">
            <button type="button" onclick="location.href='${pageContext.request.contextPath}/logout'">LOGOUT</button>
            <button type="button" onclick="location.href='${pageContext.request.contextPath}/mypageD?id=${member.id}'">MYPAGE</button>
        </div>
    </div>
    <!-- // 로그인 후 화면-->

    <!--로그인 전 화면-->
    <div id="header-miniprofileBox__guest">
        <button id="header-button__b1" type="button" onclick="location.href='${pageContext.request.contextPath}/memberL'">LOGIN</button>
        <button id="header-button__b2" type="button" onclick="location.href='${pageContext.request.contextPath}/member'">JOIN</button>
    </div>
    <!-- // 로그인 전 화면-->
</div>

</body>
</html>