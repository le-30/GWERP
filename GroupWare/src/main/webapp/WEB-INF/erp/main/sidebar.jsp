<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="./../common/common.jsp" %>
<!-- /WEB-INF/views/sidebar.jsp -->
<style>
/* ===== 사이드바 스타일 ===== */
#sideBar {
    width: 250px;
    height: calc(100vh - 7vh);
    background-color: #f9fafa;
    position: fixed;
    left: 0;
    top: 7vh;
    padding: 15px;
    box-sizing: border-box;
    overflow-y: auto;
    overflow-x: hidden;
    will-change: transform;
    line-height: 1.8 !important; /* 기본 줄 간격 유지 */
}

/* 사이드바 아이템 */
.sideTr {
    width: 100%;
    height: 40px;
    border-radius: 0.5rem;
    display: flex;
    align-items: center;
    font-weight: bold;
    color: #687482;
    margin-top: 6px !important;
    padding: 10px !important;
    box-sizing: content-box !important;
    font-size: 14px !important;
    line-height: 1.8 !important; /* 줄 간격 고정 */
    cursor: pointer;
}

/* 사이드바 호버 효과 */
.sideTr:hover {
    background-color: #efefef;
    transform: none !important; /* 본문과 겹치는 영향 제거 */
}

/* 프로필 */
.profile-container {
    display: flex;
    align-items: center;
    gap: 12px;
}

div#prof {
    width: 50px;
    height: 50px;
    border-radius: 40%;
    background-color: #239afe;
    color: white;
    display: flex;
    align-items: center;  
    justify-content: center;
    font-weight: bold;
}

#top_prof {
    display: flex;
    flex-direction: column;
    padding: 6px 12px;
    border-radius: 8px;
}

.emp_nm {
    font-weight: bold;
    font-size: 14px;
    color: #4a4a4a;
}

.dept {
    font-weight: normal;
    color: gray;
    font-size: 10pt;
    display: flex;
    padding-top: 3px;
}

/* 사이드바 안의 테이블 스타일 초기화 */
#sideBar table {
    border-radius: 0 !important;
    overflow: visible !important;
}


.badge {
  background-color: #ff4d4d;
  color: white;
  border-radius: 50px;
  font-size: 11px;
  padding: 2px 6px;
  margin-left: 6px;
  vertical-align: middle;
}

</style>

<div id="sideBar">
    <div id="sideTop">
        <div class="profile-container">
            <div id="prof">${sessionScope.emp_nm}</div>
            <div id="top_prof">
                <div>
                    <span class="emp_nm">${sessionScope.emp_nm}</span>
                    <span class="dept">${sessionScope.dept_nm} · ${sessionScope.position_nm}</span>
                </div>
            </div>
        </div>
    </div>

    <div id="sideMiddle">
    <div class="sideTr" data-action="page" data-target="msg">
        <i class="fas fa-paper-plane sideIcon"></i>메신저
         <span id="msg-badge" style="margin-left: auto; background: red; color: white; padding: 2px 8px; border-radius: 10px; font-size: 12px; display: none;"></span>
    </div>
<!--     <div class="sideTr" data-action="page" data-target="todo">
        <i class="fas fa-bell sideIcon"></i>To-Do
    </div> -->
    <div class="sideTr" data-action="page" data-target="notice">
        <i class="fas fa-flag sideIcon"></i>공지사항
    </div>
    <div class="sideTr" data-action="page" data-target="emp" >
        <i class="fas fa-users sideIcon"></i>구성원
    </div>
   <!--  <div class="sideTr" data-action="page" data-target="calender">
        <i class="fas fa-calendar-check sideIcon"></i>캘린더
    </div> -->
    <div class="sideTr" data-action="page" data-target="commute">
        <i class="fas fa-clock sideIcon"></i>출퇴근
    </div>
    <div class="sideTr" data-action="page" data-target="vacation">
        <i class="fas fa-plane sideIcon"></i>휴가
    </div>
    <div class="sideTr" data-action="page" data-target="appr">
        <i class="fas fa-pen-nib sideIcon"></i>전자결재
    </div>
    <div class="sideTr" data-action="page" data-target="pay">
        <i class="fas fa-dollar-sign sideIcon"></i>급여
    </div>
    <c:if test="${sessionScope.hasAdmin eq true}">
    <div class="sideTr" data-action="page" data-target="admin">
        <i class="fas fa-dollar-sign sideIcon"></i>관리자페이지
    </div>
    </c:if>
    
</div>
</div>  
