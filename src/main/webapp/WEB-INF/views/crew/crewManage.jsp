<!--
작성자: 문수빈
페이지이름: crewManage.jsp
페이지설명: 크루 관리 페이지 (크루장 전용)
페이지 생성일: 2023/02/05
-->

<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.trip.seocance.util.DateTimeFormatUtil" %>
<c:set var="dateYMD" value="${DateTimeFormatUtil.changeToYMD(crew.CDate)}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>크루게시판 - 크루 관리</title>

    <%-- 메인 스타일 시트 --%>
    <link href="${pageContext.request.contextPath}/_css/mainStyle.css" rel="stylesheet" type="text/css">

    <!-- include jQuery -->
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
            integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
            crossorigin="anonymous"></script>

    <%-- 크루 유틸 js --%>
    <script src="${pageContext.request.contextPath}/_js/crewUtils.js"></script>

    <!-- include summernote css -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

    <script>
        function popupEditJoin() {
            window.open('${pageContext.request.contextPath}/crewM/editJoin?crewNo=${crew.crewNo}&question1=${crew.question1}&question2=${crew.question2}&question3=${crew.question3}', "크루가입 수정", "width = 800, height = 450, top = 400, left = 1200");
        }
        function getJoinInfo(id){
            window.open('${pageContext.request.contextPath}/crewJ/info?id='+id+'&crewNo=${crew.crewNo}', "크루가입서 보기", "width = 700, height = 350, top = 800, left = 1200");
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
            크루 관리
        </div>
        <%-- 게시판 드릴다운 --%>
        <span class="common-top__drilldownbox">
                    <a href="#" style="color: #FF8000;">크루 게시판</a>
                    <span> > </span>
                    <a href="#">크루 관리</a>
            </span>
    </div>

    <div class="common-miniTitle" style="top:45px; width: 1120px; font-size: 32px">
        크루 정보
    </div>
    <%-- 크루 정보 컨테이너 --%>
    <div class="crew-infoContainer">
        <div class="crew-info__infobox">

            <%-- 크루 로고 : 수정 --%>
            <div class="crew-info__item" style="margin-top: 20px">
                <span>로고 :</span>
                <div class="crew-logobox" style="width: 100px; height: 110px;">
                    <img id="crewM_img" src="${pageContext.request.contextPath}/_image/crew/logo/${crew.crewImgFileName}"
                         alt="crew-logo"/>
                    <form id="crewM-form-img" enctype="multipart/form-data">
                        <label id="crewD-label--img" class="crew-label--upload" for="crewM_input--image">변경</label>
                        <input type="file" name="crewImgFile" id="crewM_input--image"
                               onchange="setImg_m(event,'${pageContext.request.contextPath}',${crew.crewNo})">
                    </form>
                </div>
            </div>

            <%-- 크루 명 --%>
            <div class="crew-info__item">
                <span>크루명 :</span>
                <span class="crew-namelabel">${crew.crewName}</span>
            </div>

            <%-- 크루 설립일 --%>
            <div class="crew-info__item">
                크루설립일 :
                <span class="crew-namelabel">${dateYMD}</span>
            </div>

            <%-- 크루 등급 --%>
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

            <%-- 크루 포인트 --%>
            <div class="crew-info__item">
                크루포인트 :
                <div class="crew-info__pointbar--holder">
                    <div class="crew-info__pointbar--bar">${crew.crewPoint}</div>
                </div>
            </div>
        </div>

        <%-- 관심 지역 : 수정 --%>
        <div class="crew-info__introbox">

            <div id="crewM-info--area" class="crew-info__item" style="margin-top: 40px;">
                관심지역 :
                <span id="crewM-label--area" class="crew-namelabel">${crew.areaList}</span>
                <button id="crewM-btn--modifyArea" class="crew-button"
                        onclick="goAreaEditMode('${pageContext.request.contextPath}',${crew.crewNo})">수정
                </button>
            </div>


            <%-- 크루소개(간략) : 수정 --%>
            <div class="crew-info__item">
                <span>크루소개(간략) :</span><br/>
                <form id="crewM-form--intro" method="post">
                    <textarea id="crewM-textArea--intro" name="intro">${crew.intro}</textarea>
                    <button class="crew-button"
                            onclick="submitIntro('${pageContext.request.contextPath}',${crew.crewNo})"
                            style="position: relative; bottom: 7px;">수정
                    </button>
                </form>
            </div>

            <%-- 크루소개(상세) : 수정 --%>
            <div id="" class="crew-info__item" style="border: none">
                <span>크루소개(상세) :</span>
                <span id="crewM-label-introD" class="crew-infolabel">
                    ${crew.introDetail}
                </span>
                <button id="crewM-btn--modifyInfo" class="crew-button"
                        onclick="goIntroEditMode('${crew.introDetail}','${pageContext.request.contextPath}',${crew.crewNo})">
                    수정
                </button>
                <form id="crewM-form--introD" method="post">
                    <label id="crewM-editBox--intro">
                        <%-- 수정 양식 추가 되는 곳 --%>
                    </label>
                </form>
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
                                <img src="${pageContext.request.contextPath}/_image/crew/profile/${crew.member.member_img}"
                                     alt="profile"/>
                            </div>
                            <div style="display: inline-block; position: relative; bottom: 18px">${crew.member.nickname}</div>
                        </div>
                    </td>
                </tr>
                <%-- 크루원 목록 --%>
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
                                <div style="display: inline-block; position: relative; bottom: 18px">${crewMember.member.id}
                                    <form id="crewM-form--assign" method="post" style="display: inline-block">
                                        <input type="hidden" name="member.id" value="${crewMember.member.id}"/>
                                        <input type="hidden" name="regNo" value="${crewMember.regNo}"/>
                                        <button type="button" class="crew-button"
                                                onclick="giveCrewMaster('${pageContext.request.contextPath}',${crew.crewNo})">
                                            위임
                                        </button>
                                    </form>
                                    <button type="button" class="crew-button"
                                            onclick="DenyOrKick('${pageContext.request.contextPath}',${crewMember.regNo})">
                                        강퇴
                                    </button>
                                </div>
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
            <button id=crewM-btn--modifyJoin class="crew-button" onclick="popupEditJoin()"
                    style="float: right; margin-top: 2px">가입 양식 수정
            </button>
        </div>
        <div id="crewM-recruiutBox" class="crew-recruitContainer">
            <label id="crewM-recruit">
                ${crew.recruit}
            </label>
            <form id="crewM-form--recruit" method="post">
                <label id="crewM-editBox--recuit">
                    <%-- 수정 양식 추가 되는 곳 --%>
                </label>
            </form>
        </div>
        <button id=crewM-btn--modifyRecuit class="crew-button"
                onclick="goRecruitEditMode('${pageContext.request.contextPath}',${crew.crewNo})"
                style="float: right; margin-top: 7px">수정
        </button>
    </div>


    <%-- 가입대기자 정보 --%>
    <div class="common-miniTitle" style="width: 1120px; font-size: 32px;">
        가입 대기
    </div>
    <div class="crewM-container--bottom">
        <div id="crewM-container__wating" class="crew-memberContainer">
            <table id="crewM-container__wating--top" class="crew-memberTbl--top">
                <tr class="crew-memberTbl__header">
                    <td style="width: 160px">대기순번</td>
                    <td>멤버</td>
                </tr>
            </table>
            <table class="crew-memberTbl--bottom">

                <%-- 가입대기자 목록 출력 --%>
                <c:forEach items="${watingMembers}" var="watingMember" varStatus="i">
                    <tr class="common-tbl__item">
                        <td style="font-size: 20px; width: 90px">
                                ${i.index+1}
                        </td>
                        <td>
                            <div class="crewM-member--idbox">
                                <div class="crew-member--photo">
                                    <img src="${pageContext.request.contextPath}/_image/profile/${watingMember.member.member_img}"
                                         alt="profile"/>
                                </div>
                                <div style="display: inline-block; position: relative; bottom: 18px;">${watingMember.member.id}</div>
                                <span class="crewM-member--idbox__btnbox">
                                        <button class="crew-button" type="button"
                                                onclick="getJoinInfo('${watingMember.member.id}')">가입서 보기</button>
                                        <button type="button" class="crew-button"
                                                onclick="agreeJoin('${pageContext.request.contextPath}',${watingMember.regNo})">승인</button>
                                        <button type="button" class="crew-button"
                                                onclick="DenyOrKick('${pageContext.request.contextPath}',${watingMember.regNo})">거절</button>
                                </span>
                            </div>
                        </td>
                    </tr>
                </c:forEach>


            </table>
        </div>
    </div>
</section>

<%-- footer --%>
<footer>
    <jsp:include page="../footer.jsp"/>
</footer>

</body>
</html>