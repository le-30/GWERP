<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./../common/common.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<h1>월별 급여</h1>

<form method="get" action="${pageContext.request.contextPath}/salary/list.erp">

    <label>급여월:</label>
    <input type="month" name="month" value="${param.month}" />

    <c:if test="${cmmNm eq '사장' or deptNm eq '인사팀'}">
        <label>검색조건:</label>
        <select name="type">
            <option value="">선택하세요</option>
            <option value="empNm" ${param.type == 'empNm' ? 'selected' : ''}>사원명</option>
            <option value="deptNm" ${param.type == 'deptNm' ? 'selected' : ''}>부서명</option>
            <option value="cmmNm" ${param.type == 'cmmNm' ? 'selected' : ''}>직급명</option>
        </select>
    </c:if>

    <input type="text" name="keyword" value="${param.keyword}" />
    <button type="submit">조회</button>
</form>

<hr />

<c:set var="isEmpSearch" value="${param.type == 'empNm' and not empty param.keyword}" />
<c:set var="totalHoursSum" value="0" />
<c:set var="overtimeHoursSum" value="0" />
<c:set var="totalPaySum" value="0" />

<table border="1" width="100%">
    <tr>
        <th>날짜</th>
        <th>사번</th>
        <th>이름</th>
        <th>부서</th>
        <th>직급</th>
        <th>근무시간</th>
        <th>초과근무</th>
        <th>기본급</th>
        <th>초과수당</th>
        <th>총급여</th>
    </tr>

    <c:set var="baseRate" value="13000" />

    <c:forEach var="list" items="${lists}">
        <tr>
            <td><fmt:formatDate value="${list.work_date}" pattern="yyyy-MM-dd" /></td>
            <td>${list.emp_no}</td>
            <td>${list.empNm}</td>
            <td>${list.deptNm}</td>
            <td>${list.cmmNm}</td>
            <td>${list.total_hours}시간</td>
            <td>${list.overtime_hours}시간</td>

            <c:set var="rate" value="${baseRate}" />
            <c:if test="${list.cmmNm == '팀장'}">
                <c:set var="rate" value="${baseRate * 1.2}" />
            </c:if>
            <c:if test="${list.cmmNm == '부장'}">
                <c:set var="rate" value="${baseRate * 1.2 * 1.2}" />
            </c:if>

            <c:set var="baseSalary" value="${list.total_hours * rate}" />
            <c:set var="overtimePay" value="${list.overtime_hours * rate * 1.5}" />
            <c:set var="totalPay" value="${baseSalary + overtimePay}" />

            <c:if test="${isEmpSearch}">
                <c:set var="totalHoursSum" value="${totalHoursSum + list.total_hours}" />
                <c:set var="overtimeHoursSum" value="${overtimeHoursSum + list.overtime_hours}" />
                <c:set var="totalPaySum" value="${totalPaySum + totalPay}" />
            </c:if>

            <td><fmt:formatNumber value="${baseSalary}" pattern="#,###" />원</td>
            <td><fmt:formatNumber value="${overtimePay}" pattern="#,###" />원</td>
            <td><strong><fmt:formatNumber value="${totalPay}" pattern="#,###" /> 원</strong></td>
        </tr>
    </c:forEach>
</table>

<c:if test="${isEmpSearch}">
    <table border="1" align="right" style="margin-top:15px; width:300px;">
        <tr>
            <th style="width: 100px;">총급여 합계</th>
            <td>
                <strong><fmt:formatNumber value="${totalPaySum}" pattern="#,###" /> 원</strong><br/>
                <small>(${totalHoursSum}시간 + ${overtimeHoursSum}시간 초과)</small>
            </td>
        </tr>
    </table>
</c:if>
