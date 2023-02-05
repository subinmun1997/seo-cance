<%--
  Created by IntelliJ IDEA.
  User: 문수빈
  Date: 2023-02-04
  Time: 22:00
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <link href="${pageContext.request.contextPath}/_css/mainStyle.css" type="text/css" rel="stylesheet">

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js"></script>
    <script type="text/javascript" src="http://davidlynch.org/projects/maphilight/jquery.maphilight.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            if(${result == "true"}){
                alert("로그아웃되었습니다.");
            }
            if(${removeResult == 0}){
                alert("계정 탈퇴가 완료되었습니다. 그동안 이용해주셔서 감사합니다.");
            }
        });
        $(function () {
            $.fn.maphilight.defaults = {
                fill: true,
                fillColor: '000000',
                fillOpacity: 0.2,
                stroke: true,
                strokeColor: '495c75',
                strokeOpacity: 1,
                strokeWidth: 1.2,
                fade: true,
                alwaysOn: false
            }
            $('.map').maphilight();
        });
    </script>

    <title>MAIN</title>
</head>
<body>
<!--헤더-->
<div>
    <jsp:include page="header.jsp"/>
</div>
<div id="main_container">

    <!--배경사진-->
    <div id="main_img--seoul">
        <img src="${pageContext.request.contextPath}/_image/main/seoul/seoul2.png" width="1600px;" height="500px;">
    </div>

    <hr style=" width:100%; color:#bac8d9; margin-top: 40px">

    <!--추천코스-->
    <div id="main_bestcourse">
        <p>BEST COURSE</p>

        <c:forEach items="${reviewList}" var="review" varStatus="status">
            <a href="${pageContext.request.contextPath}/review/${review.reviewNo}"><img id="img${status.count}" src="${pageContext.request.contextPath}/_image/review/${review.reviewNo}/course.png" width="300px" height="250px"></a>
        </c:forEach>

    </div>

    <hr style=" width:100%; color:#bac8d9; margin-top: 40px">

    <!--지도-->
    <div id="main_map--text">
        <p>SEOUL AREA</p>
    </div>
    <div id="main_map">
        <img class="map" src="${pageContext.request.contextPath}/_image/main/seoul/map-fi-c-1.png" usemap="#image-map" alt="map"/>
        <map name="image-map">
            <area target="" alt="광화문" title="광화문" href="${pageContext.request.contextPath}/areaL?sigungu=3" coords="337,150,58" shape="circle">
            <area target="" alt="홍대" title="홍대" href="${pageContext.request.contextPath}/areaL?sigungu=7" coords="350,260,52" shape="circle">
            <area target="" alt="강남" title="강남" href="${pageContext.request.contextPath}/areaL?sigungu=1" coords="510,400,51" shape="circle">
            <area target="" alt="여의도" title="여의도" href="${pageContext.request.contextPath}/areaL?sigungu=5" coords="225,300,62" shape="circle">
            <area target="" alt="잠실" title="잠실" href="${pageContext.request.contextPath}/areaL?sigungu=6" coords="615,350,52" shape="circle">
            <area target="" alt="명동" title="명동" href="${pageContext.request.contextPath}/areaL?sigungu=4" coords="460,156,420,300" shape="rect">
            <area target="" alt="강북" title="강북" href="${pageContext.request.contextPath}/areaL?sigungu=2" coords="480,77,54" shape="circle">
        </map>
    </div>

    <hr style=" width:100%; color:#bac8d9; margin-top: 40px">

    <!--인기크루-->
    <div id="main_crew">
        <div>
            <div id="main_crew--text">
                <div id="main_crew--text1">
                    <p style="border: 1px solid; background-color: #5882FA; color: white; padding: 10px;">NEW
                        CREW</p>
                </div>

                <div id="main_crew--text2">
                    <p style="border: 1px solid; background-color: #5882FA; color: white; padding: 10px;">BEST CREW
                        POST</p>
                </div>
            </div>
        </div>

        <div id="main_crew--container">
            <div id="main_crew--bc">
                <div class="crewBox">

                    <button id="prevBtn"> &#10094;</button>
                    <div id="main_crew--bc--photo">
                        <c:forEach items="${crewList}" var="crew">
                            <div class="crewList">
                                <a href="${pageContext.request.contextPath}/crewD?crewNo=${crew.crewNo}"><img src="${pageContext.request.contextPath}/_image/crew/logo/${crew.crewImgFileName}" width="230px" height="200px" alt="${crew.crewName}" class="crewImg"></a>
                                <span class="crewName">${crew.crewName}</span>
                            </div>
                        </c:forEach>
                    </div>

                    <button id="nextBtn">&#10095;</button>
                    <script src ="${pageContext.request.contextPath}/_js/main.js"></script>
                </div>
            </div>

            <div id="main_crew--bcp">
                <div id="main_crew--bcp--table">
                    <table style="width: 800px; height: 250px; border-collapse: collapse">
                        <thead>
                        <tr style="height:35px; line-height: 40px; text-align:center; color: white; font-size: 18px; background-color: #1b3067;">
                            <th>CREW</th>
                            <th>CATEGORY</th>
                            <th>TITLE</th>
                            <th>WRITER</th>
                        </tr>
                        </thead>
                        <tbody style="text-align: center; font-family: nanumB; font-size: 16px;">
                        <c:forEach items="${crewPosts}" var="post">
                            <tr>
                                <td>${post.crew.crewName}</td>
                                <td>${post.category}</td>
                                <td><a href="${pageContext.request.contextPath}/crew/board/${post.postNo}"><b>${post.title}</b></a></td>
                                <td>${post.member.nickname}</td>
                            </tr>
                        </c:forEach>

                        <%--                            <tr>--%>
                        <%--                                <td>돌고래와춤을</td>--%>
                        <%--                                <td>맛집</td>--%>
                        <%--                                <td><a href="#"><b>애완 돌고래 동반 가능한 맛집 리스트</b></a></td>--%>
                        <%--                                <td>young2</td>--%>
                        <%--                            </tr>--%>
                        <%--                            <tr>--%>
                        <%--                                <td>청사모</td>--%>
                        <%--                                <td>쇼핑</td>--%>
                        <%--                                <td><a href="#"><b>청바지도 감성이 있다구요</b></a></td>--%>
                        <%--                                <td>kki0829</td>--%>
                        <%--                            </tr>--%>
                        <%--                            <tr>--%>
                        <%--                                <td>인생한방</td>--%>
                        <%--                                <td>자유</td>--%>
                        <%--                                <td><a href="#"><b>찐 명당 알려준다 드루와</b></a></td>--%>
                        <%--                                <td>gogojy</td>--%>
                        <%--                            </tr>--%>
                        <%--                            <tr>--%>
                        <%--                                <td>멍멍멍</td>--%>
                        <%--                                <td>자유</td>--%>
                        <%--                                <td><a href="#"><b>강아지 팔자가 좋다는건 옛말</b></a></td>--%>
                        <%--                                <td>bboong</td>--%>
                        <%--                            </tr>--%>
                        <%--                            <tr>--%>
                        <%--                                <td>freeflux</td>--%>
                        <%--                                <td>자유</td>--%>
                        <%--                                <td><a href="#"><b>이모티콘 모음입니다..m^_^m</b></a></td>--%>
                        <%--                                <td>kkh123</td>--%>
                        <%--                            </tr>--%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</div>

<!--푸터-->
<div>
    <jsp:include page="footer.jsp"/>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/_js/mainUtil.js"></script>
</body>
</html>