<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./../common/common.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 제목 -->
<div style="text-align: center; margin-bottom: 20px; font-size: 28px; font-weight: bold; color: #34495e;">
    🕘 월별 급여
</div>

<!-- 검색 폼 -->
<div style="display: flex; justify-content: center; gap: 15px; margin-bottom: 20px;">
    <form method="get" action="${pageContext.request.contextPath}/salary/list.erp" style="display: flex; gap: 10px; align-items: center;">
        <div>
            <label for="month" style="font-size: 16px; font-weight: bold;">급여월:</label>
            <input type="month" name="month" value="${param.month}" style="padding: 8px 12px; border: 1px solid #ccc; border-radius: 5px;">
        </div>

        <c:if test="${cmmNm eq '사장' or deptNm eq '인사팀'}">
            <div>
                <label for="type" style="font-size: 16px; font-weight: bold;">검색조건:</label>
                <select name="type" style="padding: 8px 12px; border: 1px solid #ccc; border-radius: 5px;">
                    <option value="">선택하세요</option>
                    <option value="empNm" ${param.type == 'empNm' ? 'selected' : ''}>사원명</option>
                    <option value="deptNm" ${param.type == 'deptNm' ? 'selected' : ''}>부서명</option>
                    <option value="cmmNm" ${param.type == 'cmmNm' ? 'selected' : ''}>직급명</option>
                </select>
            </div>
        </c:if>

        <div>
            <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어 입력" style="padding: 8px 12px; border: 1px solid #ccc; border-radius: 5px;">
        </div>

        <div>
            <button type="submit" style="padding: 8px 16px; background-color: #3498db; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold;">
                조회
            </button>
        </div>
    </form>
</div>

<hr style="border: 1px solid #ddd;">

<!-- 급여 리스트 테이블 -->
<div style="background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
    <div style="font-weight: bold; background-color: #f9f9f9; padding: 12px; border-radius: 8px; box-shadow: inset 0 1px 3px rgba(0,0,0,0.1); margin-bottom: 10px;">
        <div style="display: grid; grid-template-columns: repeat(10, 1fr); font-size: 16px; text-align: center;">
            <div>날짜</div>
            <div>사번</div>
            <div>이름</div>
            <div>부서</div>
            <div>직급</div>
            <div>근무시간</div>
            <div>초과근무</div>
            <div>기본급</div>
            <div>초과수당</div>
            <div>총급여</div>
        </div>
    </div>

    <c:set var="baseRate" value="13000" />
    <c:forEach var="list" items="${lists}">
        <div style="display: grid; grid-template-columns: repeat(10, 1fr); padding: 12px 10px; border-bottom: 1px solid #eee; align-items: center; font-size: 14px; text-align: center;">
            <div><fmt:formatDate value="${list.work_date}" pattern="yyyy-MM-dd" /></div>
            <div>${list.emp_no}</div>
            <div>${list.empNm}</div>
            <div>${list.deptNm}</div>
            <div>${list.cmmNm}</div>
            <div>${list.total_hours}시간</div>
            <div>${list.overtime_hours}시간</div>

            <c:set var="rate" value="${baseRate}" />
            <c:if test="${list.cmmNm == '팀장'}">
                <c:set var="rate" value="${baseRate * 1.2}" />
            </c:if>
            <c:if test="${list.cmmNm == '부장'}">
                <c:set var="rate" value="${baseRate * 1.2 * 1.2}" />
            </c:if>

            <!-- 기본급, 초과수당, 총급여 계산 -->
            <c:set var="baseSalary" value="${list.total_hours * rate}" />
            <c:set var="overtimePay" value="${list.overtime_hours * rate * 1.5}" />
            <c:set var="totalPay" value="${baseSalary + overtimePay}" />

            <div><fmt:formatNumber value="${baseSalary}" pattern="#,###" />원</div>
            <div><fmt:formatNumber value="${overtimePay}" pattern="#,###" />원</div>
            <div><strong><fmt:formatNumber value="${totalPay}" pattern="#,###" /> 원</strong></div>
        </div>
    </c:forEach>
</div>

<!-- 총 급여 합계 -->
<c:if test="${param.type == 'empNm' and not empty param.keyword}">
    <div style="margin-top: 20px; background: #ecf0f1; padding: 15px; text-align: right; font-size: 18px; border-radius: 5px;">
        <strong>총급여 합계:</strong> <fmt:formatNumber value="${totalPaySum}" pattern="#,###" /> 원
        <br/>
        <small>(${totalHoursSum}시간 + ${overtimeHoursSum}시간 초과)</small>
    </div>
</c:if>
