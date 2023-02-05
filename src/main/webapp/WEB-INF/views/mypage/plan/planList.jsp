<!--
작성자: 문수빈
페이지이름: planList.jsp
페이지설명: 사용자가 작성한 플래너 목록을 보여주는 페이지
페이지 생성일: 23/02/05
-->

<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>플래너 목록</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/_css/mainStyle.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/_js/mainJs.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#btn").click(function () {
                $("#popup").fadeIn();
            });
            $("#popdown").click(function () {
                $("#popup").fadeOut();
            });
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
<!-- // header -->

<!-- 마이페이지 container -->
<div class="planL-container">

    <!-- 마이페이지 네비바 -->
    <div class="planL-navbox">
        <ul class="planL-navbox__ul--blue">
            <li class="planL-navbox__li--big">마이 페이지</li>
            <li class="planL-navbox__li--small"><a href="${pageContext.request.contextPath}/mypageD?id=${member.id}" class="planL-navbox__a--blue"><img class="planL-navbox__img--small" src="${pageContext.request.contextPath}/_image/mypage/person.png">&nbsp;  개인 정보</a></li>
            <li class="planL-navbox__li--small"><a href="${pageContext.request.contextPath}/users/${member.id}/planners" class="planL-navbox__a--blue"><img class="planL-navbox__img--small" src="${pageContext.request.contextPath}/_image/mypage/planner.png">&nbsp;&nbsp;내 플래너</a></li>
        </ul>
    </div>
    <!-- // 마이페이지 네비바-->

    <!-- 플래너 목록 container -->
    <div class="planL-planbox">

        <!-- 플래너 목록 제목 -->
        <div class="planL-titlebox">
            <span class="planL-titlebox--span__big">내 플래너</span>
            <button class="planL-titlebox--button__blue" id="btn">플래너 작성</button>
        </div>
        <!-- // 플래너 목록 제목-->

        <!-- 플래너 목록 시작 -->
        <div class="planL-listbox">

            <!-- varitems로 변경 후 데이터 가져와서 뿌릴 예정, 플래너 각 고유 id 필요하기에 플래너 번호 필수 ! -->
            <c:forEach items="${planners}" var="planner" varStatus="status">
                <div class="planL-detailbox">

                    <div class="planL-detailmap" >
                        <div class="planL-map" id="map${status.count}" onclick="location.href='${pageContext.request.contextPath}/users/${member.id}/planners/${planner.plannerNo}'" ></div> <!-- 플래너 상세 페이지로 이동하는 경로 -->
                    </div>

                    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cb0b3988eb15f5d9ee7b535c89c89b5c"></script>
                    <script>
                        /* 지도 생성 */
                        var container = document.getElementById('map${status.count}');
                        var options = {
                            center: new kakao.maps.LatLng(37.5354902, 126.976431),
                            level: 9
                        };
                        var map = new kakao.maps.Map(container, options);
                        /* 폴리라인 생성 */
                        var polyline = new kakao.maps.Polyline({
                            map: map,
                            path: [],
                            strokeWeight: 3,
                            strokeColor: '#5882fa',
                            strokeOpacity: 1,
                            strokeStyle: 'solid'
                        });
                        /*for문 생성 */
                        <c:forEach items="${plans}" var="plan" varStatus="plan_status">
                        <c:if test="${planner.plannerNo eq plan.planner.plannerNo}">
                        /* 지도에 마커 생성 */
                        /* 서울역 마커 */
                        var markerPosition  = new kakao.maps.LatLng(${plan.y}, ${plan.x});
                        var marker = new kakao.maps.Marker({
                            position: markerPosition
                        });
                        marker.setMap(map);
                        /* 서울역 경로 추가  */
                        var point =  new kakao.maps.LatLng(${plan.y}, ${plan.x});
                        var path = polyline.getPath();
                        path.push(point);
                        polyline.setPath(path);
                        </c:if>
                        </c:forEach>
                    </script>

                    <div class="planL-detailinfo">
                        <span class="planL-detailinfo__span--date">
                                <fmt:formatDate value="${planner.getFDate()}" pattern="yyyy-MM-dd" />
                                </span>
                        <span class="planL-detailinfo__span--dday" title="${planner.title}">${planner.title}</span>
                        <fmt:parseNumber value="${planner.getFDate().getTime() / (1000*60*60*24)}" integerOnly="true" var="first"/>
                        <fmt:parseNumber value="${planner.getLDate().getTime() / (1000*60*60*24)}" integerOnly="true" var="last"/>
                        <span class="planL-detailinfo__span--days">${last - first + 1}DAYS</span>
                        <button onclick="deletePlanner('${planner.plannerNo}','${member.id}','${pageContext.request.contextPath}')" class="planL-detailinfo__button--blue">삭제</button>
                    </div>

                </div>
            </c:forEach>

        </div>
        <!-- // 플래너 목록 시작-->

    </div>
    <!-- // 플래너 목록 container-->

</div>
<!-- // 마이페이지 container-->

<!-- 플래너 작성 버튼 클릭시 팝업창 -->
<div class="planL-popupcontainer" id="popup">

    <div class="planL-popbox">

        <!-- 플래너 팝업창 header 부분 -->
        <div class="planL-popheadbox">
            <span class="planL-popheadbox__span--big">플래너 만들기</span>
            <button class="planL-popheadbox__button--big" id="popdown">닫기</button>
        </div>
        <!-- // 플래너 팝업창 header 부분 -->

        <!-- 플래너 팝업창 입력 부분 -->
        <div class="planL-popcontentbox">
            <form action="${pageContext.request.contextPath}/users/${member.id}/planners/new" method="get" name="popupFrm" onsubmit="return popupCheck()">

                <div class="planL-popdetailbox">
                    <span class="planL-popdetailbox__span--big">여행제목</span>
                    <input type="text" name="title" placeholder="20자 내로 입력해주세요" maxlength="20" class="planL-popdetailbox__input--gray" required>
                </div>

                <div class="planL-popdetailbox">
                    <span class="planL-popdetailbox__span--big">여행기간</span>
                    <input type="date" name="fDate" class="planL-popdetailbox__input--date" required>
                    <span class="planL-popdetailbox__span--small">~</span>
                    <input type="date" name="lDate" class="planL-popdetailbox__input--date" required>
                </div>

                <div class="planL-popdetailbox">
                    <span class="planL-popdetailbox__span--big">설명</span>
                    <input type="text" name="intro" placeholder="30자 내로 입력해주세요" maxlength="30" class="planL-popdetailbox__input--gray" value="">
                </div>

                <div class="planL-popbtnbox">
                    <input type="submit" class="planL-popbtnbox__input--blue" value="플래너 만들기">
                </div>

            </form>
        </div>
        <!-- // 플래너 팝업창 입력 부분 -->

    </div>
</div>
<!-- // 플래너 작성 버튼 클릭시 팝업창 -->

<!-- footer -->
<div class="memberL-footer">
    <%@ include file="../../footer.jsp" %>
</div>
<!-- // footer -->
</body>
</html>