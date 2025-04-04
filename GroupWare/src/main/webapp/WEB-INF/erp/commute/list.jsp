<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ include file="./../common/common.jsp" %>

<h1>출근표</h1>

<!-- 권한 있는 사람만 검색 가능 -->
<c:if test="${cmmNm eq '사장' or deptNm eq '인사팀' or cmmNm eq '부장'}">
    <form method="get" action="list/commute.erp">
    <select name="type">
        <option value="">선택</option>
        <option value="empNm">사원이름</option>
        <option value="deptNm">부서</option>
        <option value="cmmNm">직급</option>
    </select>
    <input type="text" name="keyword">
    <input type="submit" value="검색">
</form>
</c:if>

<table border="1">
    <tr>
        <th>날짜</th>
        <th>사원번호</th>
        <th>사원이름</th>
        <th>부서</th>
        <th>직급</th>
        <th>출근시간</th>
        <th>퇴근시간</th>
        <th>총 근무 시간</th>
        <th>초과시간</th>
    </tr>

    <c:forEach var="list" items="${lists}">
        <tr>
            <td><fmt:formatDate value="${list.work_date}" pattern="yyyy-MM-dd"/></td>
            <td>${list.emp_no}</td>
            <td>${list.empNm}</td>
            <td>${list.deptNm}</td>
            <td>${list.cmmNm}</td>
            <td><fmt:formatDate value="${list.clock_in}" pattern="HH:mm:ss"/></td>
            <td><fmt:formatDate value="${list.clock_out}" pattern="HH:mm:ss"/></td>
            <td>${list.total_hours}</td>
            <td>${list.overtime_hours}</td>
        </tr>
    </c:forEach>
</table>

<br><br>
${pageInfo.pagingHtml}

<a href="check_out/commute.erp" class="button">퇴근</a>
