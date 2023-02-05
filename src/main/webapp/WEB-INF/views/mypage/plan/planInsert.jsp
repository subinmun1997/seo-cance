<!--
작성자: 문수빈
페이지이름: planInsert.jsp
페이지설명: 사용자가 원하는 일정을 짤 수 있는 플래너 작성 페이지
페이지 생성일: 23/02/05
-->

<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <title>플래너 작성</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/_css/mainStyle.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            history.replaceState({}, null, location.pathname);
            $('.planI-daybox').click(function(e) {
                e.preventDefault();
                $('.planI-daybox').css("background-color","#1b3067");
                $(this).css("background-color","#5882fa");
            });
            $(".planI-header__button--sumbit").click(function () {
                var isValid = true;
                $('.planI-plansbox').each(function (i){
                    if($(this).children().length < 2){
                        alert("각 여행일에는 최소 1개의 일정을 추가해주세요.");
                        isValid = false;
                        return false;
                    }
                });
                $('.planI-planbox').each(function (i){
                    if($(this).find('.planI-plandetail__input--time').val() == ""){
                        alert("시간은 필수 입력 항목입니다.");
                        isValid = false;
                        return false;
                    }
                });
                var member = {
                    id : "${member.id}"
                };
                var planner = {
                    title : document.getElementById('title').value,
                    fDate : document.getElementById('f_date').value,
                    lDate : document.getElementById('l_date').value,
                    intro : document.getElementById('intro').value,
                    member : member
                };
                var planList = new Array();
                if(isValid == true){
                    $('.planI-planbox').each(function (i){
                        // 플랜 1개의 데이터
                        var plan = {
                            day : $(this).attr("data-date") + " " + $(this).find('.planI-plandetail__input--time').val(),
                            name : $(this).attr("data-place"),
                            intro : $(this).find('.planI-plandetail__input--intro').val(),
                            x : $(this).attr("data-x"),
                            y : $(this).attr("data-y")
                        };
                        // 배열에 Plan 데이터 담기
                        planList.push(plan);
                    });
                    // Plan 배열, Planner 데이터 묶기
                    var toData = {
                        planList : planList,
                        planner : planner
                    };
                    $.ajax({
                        url:"${pageContext.request.contextPath}/api/users/${member.id}/planners",
                        contentType:'application/json',
                        data: JSON.stringify(toData),
                        type:"POST",
                        success: function (data, textStatus, request) {
                            alert(data);
                            location.replace(request.getResponseHeader("location"));
                        },
                        error: function(data){
                            console.log(data.responseText);
                        }
                    });
                }
            });
        });
    </script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');
    </style>
</head>
<body>
<!-- 사용자가 입력한 여행 제목, 여행 출발일,도착일, 여행 설명 정보-->
<input type="hidden" name="title" id="title" value="${planner_user.title}" />
<input type="hidden" name="fDate" id="f_date" value="<fmt:formatDate value="${planner_user.getFDate()}" pattern="yyyy-MM-dd" />" />
<input type="hidden" name="lDate" id="l_date" value="<fmt:formatDate value="${planner_user.getLDate()}" pattern="yyyy-MM-dd" />" />
<input type="hidden" name="intro" id="intro" value="${planner_user.intro}" />
<!-- 사용자가 입력한 여행 제목, 여행 출발일,도착일, 여행 설명 정보-->

<!-- header -->
<div class="planI-header">
    <a href="${pageContext.request.contextPath}/main"><img src="${pageContext.request.contextPath}/_image/plan/logo.png"></a>

    <button class="planI-header__button--sumbit">저장</button>
    <button class="planI-header__button--close" onclick="location.href='${pageContext.request.contextPath}/planL?id=${member.id}'">닫기</button>
</div>
<!-- // header -->

<!-- 플래너 작성 container -->
<div class="planI-container">
    <!-- DAYS 나타내는 div -->
    <div class="planI-daysbox">

        <div class="planI-daysboxtitle">일정</div>

        <c:forEach items="${days}" var="day" varStatus="status">
            <div class="planI-daybox" onclick="plansChange(${status.count})">
                <span class="planI-day">DAY${status.count}</span>
                <span class="planI-date"><fmt:formatDate value="${day}" pattern="MM.dd (E)" /></span>
            </div>
        </c:forEach>

    </div>
    <!-- // DAYS 나타내는 div -->

    <!-- 해당 날짜에 대한 일정들 나타나는 div -->
    <div class="planI-planscontainer">

        <c:forEach items="${days}" var="day" varStatus="status">
            <div class="planI-plansbox" data-date="<fmt:formatDate value="${day}" pattern="yyyy-MM-dd" />">
                <div class="planI-plansboxtitle">DAY${status.count} | <fmt:formatDate value="${day}" pattern="MM.dd E요일" /></div>
            </div>
        </c:forEach>

    </div>
    <!-- // 해당 날짜에 대한 일정들 나타나는 div -->

    <!-- 키워드로 장소 검색하는 div -->
    <div id="planI-searchbox">

        <div class="planI-search">
            <form onsubmit="searchPlaces(); return false;">
                <input type="text" value="이태원 맛집" id="keyword" size="15">
                <button type="submit">검색</button>
            </form>
        </div>

        <ul id="planI-searchbox__ul--gray"></ul>

        <div id="planI-pagination"></div>
    </div>
    <!-- // 키워드로 장소 검색하는 div -->

    <!-- 지도 div -->
    <div class="planI-mapbox">
        <div class="planI-map" id="planI-map"></div>
    </div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cb0b3988eb15f5d9ee7b535c89c89b5c&libraries=services"></script>
<script>
    // 지도 생성 코드
    var markers = [];
    var container = document.getElementById('planI-map');
    var options = {
        center: new kakao.maps.LatLng(37.5536472, 126.9678003),
        level: 3
    };
    var map = new kakao.maps.Map(container, options);
    // 검색을 위한 코드 시작
    var ps = new kakao.maps.services.Places();
    // 키워드로 장소를 검색합니다
    searchPlaces();
    // 키워드 검색을 요청하는 함수입니다
    function searchPlaces() {
        var keyword = document.getElementById('keyword').value;
        if (!keyword.replace(/^\s+|\s+$/g, '')) {
            alert('키워드를 입력해주세요!');
            return false;
        }
        // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
        ps.keywordSearch( keyword, placesSearchCB);
    }
    // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
    function placesSearchCB(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {
            // 정상적으로 검색이 완료됐으면
            // 검색 목록과 마커를 표출합니다
            displayPlaces(data);
            // 페이지 번호를 표출합니다
            displayPagination(pagination);
        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
            alert('검색 결과가 존재하지 않습니다.');
            return;
        } else if (status === kakao.maps.services.Status.ERROR) {
            alert('검색 결과 중 오류가 발생했습니다.');
            return;
        }
    }
    // 검색 결과 목록과 마커를 표출하는 함수입니다
    function displayPlaces(places) {
        var listEl = document.getElementById('planI-searchbox__ul--gray'),
            menuEl = document.getElementById('planI-searchbox'),
            fragment = document.createDocumentFragment(),
            bounds = new kakao.maps.LatLngBounds(),
            listStr = '';
        // 검색 결과 목록에 추가된 항목들을 제거합니다
        removeAllChildNods(listEl);
        // 지도에 표시되고 있는 마커를 제거합니다
        removeMarker();
        for ( var i=0; i<places.length; i++ ) {
            // 마커를 생성하고 지도에 표시합니다
            var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                marker = addMarker(placePosition, i),
                itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
            // LatLngBounds 객체에 좌표를 추가합니다
            bounds.extend(placePosition);
            fragment.appendChild(itemEl);
        }
        // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
        listEl.appendChild(fragment);
        menuEl.scrollTop = 0;
        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    }
    // 검색결과 항목을 Element로 반환하는 함수입니다
    function getListItem(index, places) {
        var contextPath = '${pageContext.request.contextPath}';
        var el = document.createElement('li'),
            itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';
        if (places.road_address_name) {
            itemStr += '    <span>' + places.road_address_name + '</span>';
        } else {
            itemStr += '    <span>' +  places.address_name  + '</span>';
        }
        itemStr += '  <span class="tel">' + places.phone  + '</span>' +
            '</div>';
        itemStr += '<div class="placelist-div"><button class="placelist-div__button" onclick="planInsert(\'' + places.place_name + '\',\'' + places.y + '\',\'' + places.x + '\',\'' +   contextPath  +  '\')">+</button></div>';
        el.innerHTML = itemStr;
        el.className = 'item';
        return el;
    }
    // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
    function addMarker(position, idx, title) {
        var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
            imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
            imgOptions =  {
                spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
            },
            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
                position: position, // 마커의 위치
                image: markerImage
            });
        marker.setMap(map); // 지도 위에 마커를 표출합니다
        markers.push(marker);  // 배열에 생성된 마커를 추가합니다
        return marker;
    }
    // 지도 위에 표시되고 있는 마커를 모두 제거합니다
    function removeMarker() {
        for ( var i = 0; i < markers.length; i++ ) {
            markers[i].setMap(null);
        }
        markers = [];
    }
    // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
    function displayPagination(pagination) {
        var paginationEl = document.getElementById('planI-pagination'),
            fragment = document.createDocumentFragment(),
            i;
        // 기존에 추가된 페이지번호를 삭제합니다
        while (paginationEl.hasChildNodes()) {
            paginationEl.removeChild (paginationEl.lastChild);
        }
        for (i=1; i<=pagination.last; i++) {
            var el = document.createElement('a');
            el.href = "#";
            el.innerHTML = i;
            if (i===pagination.current) {
                el.className = 'on';
            } else {
                el.onclick = (function(i) {
                    return function() {
                        pagination.gotoPage(i);
                    }
                })(i);
            }
            fragment.appendChild(el);
        }
        paginationEl.appendChild(fragment);
    }
    // 검색결과 목록의 자식 Element를 제거하는 함수입니다
    function removeAllChildNods(el) {
        while (el.hasChildNodes()) {
            el.removeChild (el.lastChild);
        }
    }
</script>
<!-- // 지도 div -->

<!-- // 플래너 작성 container -->
<script type="text/javascript" src="${pageContext.request.contextPath}/_js/mainJs.js"></script>
</body>
</html>