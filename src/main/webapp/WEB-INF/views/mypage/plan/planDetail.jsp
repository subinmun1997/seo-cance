<!--
작성자: 문수빈
페이지이름: planDetail.jsp
페이지설명: 플래너의 상세 내역을 보여주는 페이지
페이지 생성일: 23/02/05
-->

<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>플래너 상세 목록</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/_css/mainStyle.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/_js/mainJs.js"></script>
    <script>
        // 여러 대표 이미지 중 랜덤으로 1개를 뽑아줌
        $(document).ready(function () {
            // 계정 탈퇴 실패시 알림
            if(${removeResult == 1}){
                alert("계정 탈퇴에 실패하였습니다. 다시 해주시길 바랍니다.");
            }
            $("#btn").click(function () {
                $("#popup").fadeIn();
            });
            $("#popdown").click(function () {
                $("#popup").fadeOut();
            });
            let randomNum = Math.floor(Math.random() * 5) + 1;
            $('.planD-imgbox').children('img').attr('src', '${pageContext.request.contextPath}/_image/plan/tour/tour' + randomNum + '.jpg');
            var slide = document.querySelectorAll(".planD-map");
            var listslides = document.querySelectorAll(".planD-placelist");
            var current = 0;
            function show(n){
                for(var i=0;i<slide.length;i++){
                    slide[i].style.display = "none";
                }
                slide[n].style.display = "block";
                for(var j=0;j<listslides.length;j++){
                    listslides[j].style.display = "none";
                }
                listslides[n].style.display = "block";
            }
            show(current);
        });
    </script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');
    </style>
</head>
<body>
<!-- header -->
<div class="memberL-header__div">
    <jsp:include page="../../header.jsp"/>
</div>
<!-- // header-->

<!-- container -->
<div class="planD-container">

    <!-- 내 프로필 nav -->
    <div class="planD-navbox">
        <ul class="planD-navbox__ul--blue">
            <li class="planD-navbox__li--big">마이 페이지</li>
            <li class="planD-navbox__li--small"><a href="${pageContext.request.contextPath}/mypageD?id=${member.id}" class="planD-navbox__a--blue"><img class="planD-navbox__img--small" src="${pageContext.request.contextPath}/_image/mypage/person.png">&nbsp;  개인 정보</a></li>
            <li class="planD-navbox__li--small"><a href="${pageContext.request.contextPath}/users/${member.id}/planners" class="planD-navbox__a--blue"><img class="planD-navbox__img--small" src="${pageContext.request.contextPath}/_image/mypage/planner.png">&nbsp;&nbsp;내 플래너</a></li>
        </ul>
    </div>
    <!-- // 내 프로필 nav-->

    <!-- 플래너쪽 container -->
    <div class="planD-planbox">

        <!-- 플래너 상단 (제목)-->
        <div class="planD-titlebox">
            <div class="planD-imgbox">
                <img src="${pageContext.request.contextPath}/_image/plan/tour/tour1.jpg" class="planD-imgbox--img__big">
                <span class="planD-titledetail">${planner.title}</span>

                <fmt:parseNumber value="${planner.getFDate().getTime() / (1000*60*60*24)}" integerOnly="true" var="first"/>
                <fmt:parseNumber value="${planner.getLDate().getTime() / (1000*60*60*24)}" integerOnly="true" var="last"/>

                <span class="planD-titledays">
                            <fmt:formatDate value="${planner.getFDate()}" pattern="yyyy-MM-dd" />
                            ~
                            <fmt:formatDate value="${planner.getLDate()}" pattern="yyyy-MM-dd" />
                            (${last - first + 1}일)
                        </span>

                <span class="planD-titleIntro">${planner.intro}</span>
            </div>

            <div class="planD-btnbox">

                <button class="planD-btnbox__button--blue" id="btn">수정</button>
                <button class="planD-btnbox__button--gray" onclick="deletePlanner('${planner.plannerNo}','${member.id}','${pageContext.request.contextPath}')">삭제</button>
            </div>
        </div>
        <!-- // 플래너 상단 (제목) -->

        <!-- 플래너 일정 -->
        <div class="planD-listbox">

            <!-- 플래너 상세 일정 -->
            <%-- 날짜 수만큼 foreach--%>
            <c:forEach items="${dates}" var="date" varStatus="status">
                <div class="planD-detailbox">

                    <div class="planD-datebox">
                        <div class="planD-days">DAY ${status.count}</div>
                        <div class="planD-date">
                            <fmt:formatDate value="${date}" pattern="yyyy.MM.dd" />&nbsp;
                            (<fmt:formatDate value="${date}" pattern="E" />)
                        </div>
                    </div>

                        <%--  해당 날짜의 플랜 갯수만큼--%>
                    <% int i = 1;%>
                    <c:forEach items="${plans}" var="plan" varStatus="plan_status">
                        <!-- 화면에서 보이면 주석처리 -->
                        <fmt:formatDate value="${date}" pattern="yyyy-MM-dd" var="nowDate" />
                        <fmt:formatDate value="${plan.day}" pattern="yyyy-MM-dd" var="openDate" />

                        <c:if test="${nowDate eq openDate}">

                            <div class="planD-detail">
                                <div class="planD-detailnumber">
                                    <img class="planD-detailnumber__img--navy" src="${pageContext.request.contextPath}/_image/plan/num/number<%=i%>.png">
                                </div>

                                <div class="planD-detailplace">
                                    <span class="planD-detailtime__span--small"> <fmt:formatDate value="${plan.day}" pattern="a hh:mm"/></span>
                                    <span class="planD-detailplace__span--small" title="${plan.name}">${plan.name}</span>
                                    <span class="planD-detailinfo__span--small">${plan.intro}</span>
                                    <div class="planD-detailimg" id="map${status.count}-${plan_status.count}"></div>

                                    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cb0b3988eb15f5d9ee7b535c89c89b5c"></script>
                                    <script>
                                        /* 지도 생성 */
                                        var container = document.getElementById('map${status.count}-${plan_status.count}');
                                        var options = {
                                            center: new kakao.maps.LatLng(${plan.y}, ${plan.x}),
                                            level: 3
                                        };
                                        var map = new kakao.maps.Map(container, options);
                                        /* 마커 생성 */
                                        var markerPosition  = new kakao.maps.LatLng(${plan.y}, ${plan.x});
                                        var marker = new kakao.maps.Marker({
                                            position: markerPosition
                                        });
                                        marker.setMap(map);
                                    </script>
                                </div>
                            </div>
                            <% ++i;%>

                        </c:if>
                    </c:forEach>


                </div>

            </c:forEach>
            <!-- // 플래너 상세 일정-->

        </div>
        <!-- // 플래너 일정 -->

        <!-- 플래너 경로 지도 부분 -->
        <div class="planD-mapbox">
            <div class="mapbox">

                <c:forEach items="${dates}" var="date" varStatus="status">

                    <div class="planD-map" id="maplist${status.count}"></div>
                    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cb0b3988eb15f5d9ee7b535c89c89b5c"></script>
                    <script>
                        var container = document.getElementById('maplist${status.count}');
                        var options = {
                            center: new kakao.maps.LatLng(37.5354902, 126.976431),
                            level: 9
                        };
                        var map = new kakao.maps.Map(container, options);
                        var polyline = new kakao.maps.Polyline({
                            map: map,
                            path: [],
                            strokeWeight: 3,
                            strokeColor: '#5882fa',
                            strokeOpacity: 1,
                            strokeStyle: 'solid'
                        });
                        // 마커 숫자를 위한 변수
                        var a = 0;
                        <c:forEach items="${plans}" var="plan" varStatus="plan_status">
                        <!-- 화면에서 보이면 주석처리 -->
                        <fmt:formatDate value="${date}" pattern="yyyy-MM-dd" var="nowDate" />
                        <fmt:formatDate value="${plan.day}" pattern="yyyy-MM-dd" var="openDate" />
                        <c:if test="${nowDate eq openDate}">
                        var markerPosition  = new kakao.maps.LatLng(${plan.y}, ${plan.x});
                        var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
                            imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
                            imgOptions =  {
                                spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                                spriteOrigin : new kakao.maps.Point(0, (a*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                                offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                            },
                            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                            marker = new kakao.maps.Marker({
                                position: markerPosition, // 마커의 위치
                                image: markerImage
                            });
                        marker.setMap(map);
                        /* 서울역 경로 추가  */
                        var point =  new kakao.maps.LatLng(${plan.y}, ${plan.x});
                        var path = polyline.getPath();
                        path.push(point);
                        polyline.setPath(path);
                        ++a;
                        </c:if>
                        </c:forEach>
                    </script>
                </c:forEach>

                <div class="planD-selectbox">
                    <select id="select_day" class="planD-selectbox__select--day" onchange="mapChange()">
                        <c:forEach items="${dates}" var="date" varStatus="status">
                            <option value="${status.index}">DAY${status.count}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="planD-placelistbox">
                <c:forEach items="${dates}" var="date" varStatus="status">

                    <div class="planD-placelist">

                        <% int j = 1;%>

                        <c:forEach items="${plans}" var="plan" varStatus="plan_status">
                            <!-- 화면에서 보이면 주석처리 -->
                            <fmt:formatDate value="${date}" pattern="yyyy-MM-dd" var="nowDate" />
                            <fmt:formatDate value="${plan.day}" pattern="yyyy-MM-dd" var="openDate" />

                            <c:if test="${nowDate eq openDate}">
                                <div class="planD-placedetail">
                                    <img src="${pageContext.request.contextPath}/_image/plan/num/number<%=j%>.png" class="planD-placedetail__img--navy">
                                    <span class="planD-placedetail__span--small" title="${plan.name}">${plan.name}</span>
                                </div>
                                <% ++j;%>
                            </c:if>

                        </c:forEach>

                    </div>
                </c:forEach>

            </div>
        </div>
        <!-- // 플래너 경로 지도 부분-->


    </div>
    <!-- // container-->

</div>
<!-- // 플래너 디테일-->

<!-- footer -->
<div class="planD-footer">
    <%@ include file="../../footer.jsp" %>
</div>
<!-- // footer -->

<!-- 플래너 수정 버튼 클릭시 팝업창 -->
<div class="planD-popupcontainer" id="popup">

    <div class="planD-popbox">

        <!-- 플래너 팝업창 header 부분 -->
        <div class="planD-popheadbox">
            <span class="planD-popheadbox__span--big">플래너 수정하기</span>
            <button class="planD-popheadbox__button--big" id="popdown">닫기</button>
        </div>
        <!-- // 플래너 팝업창 header 부분 -->

        <!-- 플래너 팝업창 입력 부분 -->
        <div class="planD-popcontentbox">
            <form action="${pageContext.request.contextPath}/users/${member.id}/planners/${planner.plannerNo}/edit" method="get" name="popupFrm" onsubmit="return popupCheck()">

                <div class="planD-popdetailbox">
                    <span class="planD-popdetailbox__span--big">여행제목</span>
                    <input type="text" name="title" value="${planner.title}" placeholder="20자 내로 입력해주세요" maxlength="20" class="planD-popdetailbox__input--gray" required>
                </div>

                <div class="planD-popdetailbox">
                    <span class="planD-popdetailbox__span--big">여행기간</span>
                    <input type="date" name="fDate" class="planD-popdetailbox__input--date" value="<fmt:formatDate value="${planner.getFDate()}" pattern="yyyy-MM-dd" />">
                    <span class="planD-popdetailbox__span--small">~</span>
                    <input type="date" name="lDate" class="planD-popdetailbox__input--date" value="<fmt:formatDate value="${planner.getLDate()}" pattern="yyyy-MM-dd" />">
                </div>

                <div class="planD-popdetailbox">
                    <span class="planD-popdetailbox__span--big">설명</span>
                    <input type="text" name="intro" value="${planner.intro}"  placeholder="30자 내로 입력해주세요" maxlength="30" class="planD-popdetailbox__input--gray">
                </div>

                <div class="planD-popbtnbox">
                    <input type="submit" class="planD-popbtnbox__input--blue" value="플랜 수정하기">
                </div>

            </form>
        </div>
        <!-- // 플래너 팝업창 입력 부분 -->

    </div>
</div>
<!-- // 플래너 수정 버튼 클릭시 팝업창 -->

</body>
</html>