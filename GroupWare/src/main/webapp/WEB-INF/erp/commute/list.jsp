<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="./../common/common.jsp" %>

<!-- 제목 -->
<h4 style="margin-bottom: 20px; font-size: 20px; font-weight: bold; color: #2c3e50;">
    🕘 출근표
</h4>

<!-- 권한 있는 사람만 검색 -->
<c:if test="${cmmNm eq '사장' or deptNm eq '인사팀' or cmmNm eq '부장'}">
    <form method="get" action="list/commute.erp" style="display: flex; gap: 10px; margin-bottom: 20px;">
        <select name="type" style="padding: 6px 10px; border: 1px solid #ccc; border-radius: 5px;">
            <option value="">선택</option>
            <option value="empNm">사원이름</option>
            <option value="deptNm">부서</option>
            <option value="cmmNm">직급</option>
        </select>
        <input type="text" name="keyword" placeholder="검색어 입력"
               style="padding: 6px 10px; border: 1px solid #ccc; border-radius: 5px;">
        <input type="submit" value="검색"
               style="padding: 6px 14px; background-color: #3498db; color: white; border: none; border-radius: 5px; cursor: pointer;">
    </form>
</c:if>

<!-- 출근표 리스트 -->
<div style="background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
    <!-- 헤더 -->
    <div style="display: grid; grid-template-columns: 1.5fr 1.5fr 2fr 2fr 2fr 2fr 2fr 2fr 2fr; font-weight: bold; background: #f9f9f9; padding: 10px; border-bottom: 2px solid #ddd;">
        <div>날짜</div>
        <div>사원번호</div>
        <div>사원이름</div>
        <div>부서</div>
        <div>직급</div>
        <div>출근시간</div>
        <div>퇴근시간</div>
        <div>총 근무 시간</div>
        <div>초과시간</div>
    </div>

    <!-- 리스트 -->
    <c:forEach var="list" items="${lists}">
        <div style="display: grid; grid-template-columns: 1.5fr 1.5fr 2fr 2fr 2fr 2fr 2fr 2fr 2fr; padding: 12px 10px; border-bottom: 1px solid #eee; align-items: center;">
            <div><fmt:formatDate value="${list.work_date}" pattern="yyyy-MM-dd"/></div>
            <div>${list.emp_no}</div>
            <div>${list.empNm}</div>
            <div>${list.deptNm}</div>
            <div>${list.cmmNm}</div>
            <div><fmt:formatDate value="${list.clock_in}" pattern="HH:mm:ss"/></div>
            <div><fmt:formatDate value="${list.clock_out}" pattern="HH:mm:ss"/></div>
            <div>${list.total_hours}</div>
            <div>${list.overtime_hours}</div>
        </div>
    </c:forEach>

    <!-- 페이징 -->
    <div id="paging" style="margin-top: 20px; text-align: center;">
        ${pageInfo.pagingHtml}
    </div>
</div>

<!-- 퇴근 버튼 -->
<div style="margin-top: 30px; text-align: right;">
    <a href="check_out/commute.erp"
       style="padding: 10px 20px; background-color: #e74c3c; color: white; text-decoration: none; border-radius: 5px; font-weight: bold;">
        퇴근
    </a>
</div>
