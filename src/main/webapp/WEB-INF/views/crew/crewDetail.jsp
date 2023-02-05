<!--
작성자: 문수빈
페이지이름: crewDetail.jsp
페이지설명: 크루게시판 - 크루 상세보기
페이지 생성일: 23/02/05
-->

<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page import="com.trip.seocance.util.DateTimeFormatUtil" %>
<c:set var="dateYMD" value="${DateTimeFormatUtil.changeToYMD(crew.CDate)}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>크루게시판 - 크루 상세</title>

    <%-- 메인 스타일 시트 --%>
    <link href="${pageContext.request.contextPath}/_css/mainStyle.css" rel="stylesheet" type="text/css">
    x
    <%-- 크루가입 팝업 --%>
    <script>
        function popupCrewJoin() {
            window.open("${pageContext.request.contextPath}/crewJ?crewNo=${crew.crewNo}", "크루가입", "width = 900, height = 770");
        }
    </script>
</head>
<body>
<%-- 헤더 --%>
<div>
    <jsp:include page="../header.jsp"/>
</div>

<%-- 크루 네이게이션 : 공통 --%>
<nav class="crew-navi" style="width: 1115px;">
    <span class="crew-navi__btn"><a href="${pageContext.request.contextPath}/crew/board">크루활동</a></span>
    <span class="crew-navi__btn"><a href="${pageContext.request.contextPath}/crewL">크루목록</a></span>
    <button id="crew-navi__btn--mycrew" type="button" class="crew-button">My Crew</button>
</nav>

<section class="crew-mainContainer" style="width: 1120px; text-align: left">
    <%-- 상단 제목,드릴다운 : 공통 --%>
    <div class="crew-topContainer" style="width: 1120px;">
        <%-- 제목 --%>
        <div class="common-top__title" style="color: #FAAC58">
            크루 상세
        </div>
        <%-- 게시판 드릴다운 --%>
        <span class="common-top__drilldownbox">
                    <a href="#" style="color: #FF8000;">크루 게시판</a>
                    <span> > </span>
                    <a href="#">크루 목록</a>
                    <span> > </span>
                    <a href="#">크루 상세</a>
            </span>
    </div>

    <div class="common-miniTitle" style="top:45px; width: 1120px; font-size: 32px">
        크루 정보
    </div>
    <%-- 크루 정보 컨테이너 --%>
    <div class="crew-infoContainer">
        <div class="crew-info__infobox">
            <%-- 크루 로고 --%>
            <div class="crew-info__item" style="margin-top: 20px">
                <span>로고 :</span>
                <div class="crew-logobox" style="width: 100px; height: 110px;">
                    <img src="${pageContext.request.contextPath}/_image/crew/logo/${crew.crewImgFileName}"
                         alt="crew-logo"/>
                </div>
            </div>

            <div class="crew-info__item">
                <span>크루명 :</span>
                <span class="crew-namelabel">${crew.crewName}</span>
            </div>

            <div class="crew-info__item">
                크루설립일 :
                <span class="crew-namelabel">${dateYMD}</span>
            </div>

            <div class="crew-info__item">
                크루등급 :
                <div class="crew-info__grade">
                    <%-- 크루등급별 등급사진 선택 --%>
                    <c:choose>
                        <c:when test="${crew.grade eq '돌고래'}">
                            <img src="${pageContext.request.contextPath}/_image/crew/grade/crew_grade1.png"
                                 alt="grade">
                        </c:when>
                        <c:when test="${crew.grade eq '동고래'}">
                            <img src="${pageContext.request.contextPath}/_image/crew/grade/crew_grade2.png"
                                 alt="grade">
                        </c:when>
                        <c:when test="${crew.grade eq '은고래'}">
                            <img src="${pageContext.request.contextPath}/_image/crew/grade/crew_grade3.png"
                                 alt="grade">
                        </c:when>
                        <c:when test="${crew.grade eq '금고래'}">
                            <img src="${pageContext.request.contextPath}/_image/crew/grade/crew_grade4.png"
                                 alt="grade">
                        </c:when>
                    </c:choose>
                </div>
                <button class="crew-button" style="height: 30px">등급안내</button>
            </div>

            <div class="crew-info__item">
                크루포인트 :
                <div class="crew-info__pointbar--holder">
                    <%-- 크루 포인트 및 등급 --%>
                    <div class="crew-info__pointbar--bar">${crew.crewPoint/1000 * 100}%</div>
                </div>
            </div>
        </div>

        <div class="crew-info__introbox">
            <div class="crew-info__item" style="margin-top: 112px">
                관심지역 :
                <span class="crew-namelabel">${crew.areaList}</span>
            </div>

            <div class="crew-info__item" style="border: none">
                <span>크루소개 :</span>
                <span class="crew-infolabel">
                    ${crew.introDetail}
                </span>
            </div>
        </div>
    </div>

    <div class="crew-midContainer--left">
        <div class="common-miniTitle" style="top:45px; font-size: 32px">
            <span>크루원 정보</span>
        </div>
        <%-- 크루 멤버 컨테이너 --%>
        <div class="crew-memberContainer">
            <table class="crew-memberTbl--top">
                <tr class="crew-memberTbl__header">
                    <td style="width: 160px">멤버등급</td>
                    <td>멤버</td>
                </tr>
            </table>
            <%-- 크루장 --%>
            <table class="crew-memberTbl--bottom">
                <tr class="common-tbl__item">
                    <td>
                        <div class="crew-master--decorate">
                            <span class="crew-master--decotext">크루장</span>
                            <img src="${pageContext.request.contextPath}/_image/crew/crew_master_crown.png"
                                 alt="crown">
                        </div>
                    </td>
                    <td>
                        <div class="crew-member--idbox">
                            <div class="crew-member--photo">
                                <img src="${pageContext.request.contextPath}/_image/profile/${crew.member.member_img}"
                                     alt="profile"/>
                            </div>
                            <div style="display: inline-block; position: relative; bottom: 18px">${crew.member.nickname}</div>
                        </div>
                    </td>
                </tr>

                <c:forEach items="${crewMembers}" var="crewMember">
                    <%-- 크루원 --%>
                    <tr class="common-tbl__item">
                        <td>
                            <span class="crew-member-decotext">크루원</span>
                        </td>
                        <td>
                            <div class="crew-member--idbox">
                                <div class="crew-member--photo">
                                    <img src="${pageContext.request.contextPath}/_image/profile/${crewMember.member.member_img}"/>
                                </div>
                                <div style="display: inline-block; position: relative; bottom: 18px">${crewMember.member.id}</div>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>

    <%-- 모집 공고 및 크루 가입 --%>
    <div class="crew-midContainer--right">
        <div class="common-miniTitle" style="width: 550px; top:45px; left: 65px; font-size: 32px;">
            <span>모집 공고</span>
            <security:authorize access="isAuthenticated()">
                <c:choose>
                    <c:when test="${crewMembers.contains(member.id)}">
                        <button class="crew-button" style="float: right; margin-top: 2px" >
                            크루
                            탈퇴
                        </button>
                    </c:when>
                    <c:otherwise>
                        <button class="crew-button" style="float: right; margin-top: 2px" onclick="popupCrewJoin()">
                            크루
                            가입
                        </button>
                    </c:otherwise>
                </c:choose>
            </security:authorize>
        </div>
        <div class="crew-recruitContainer">
            ${crew.recruit}
        </div>
    </div>
</section>

<%-- footer --%>
<footer>
    <jsp:include page="../footer.jsp"/>
</footer>

</body>
</html>