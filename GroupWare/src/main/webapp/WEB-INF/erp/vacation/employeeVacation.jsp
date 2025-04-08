<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file=".././common/common.jsp"%>

<div id="annualLeaveContainer" style="background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">

    <h4 style="margin-bottom: 20px;">👤 내 연차 정보</h4>

    <c:choose>
        <c:when test="${not empty employee and not empty leaveInfo}">
            <div style="display: grid; grid-template-columns: 1fr 2fr 1fr; font-weight: bold; background: #f3f9ff; padding: 10px; border-bottom: 2px solid #5dade2;">
                <div style="text-align: center;">사원번호</div>
                <div style="text-align: center;">사원명</div>
                <div style="text-align: center;">잔여 연차</div>
            </div>
            <div style="display: grid; grid-template-columns: 1fr 2fr 1fr; padding: 12px 10px; border-bottom: 1px solid #eee; align-items: center;">
                <div style="text-align: center;">${employee.emp_no}</div>
                <div style="text-align: center;">${employee.emp_nm}</div>
                <div style="text-align: center; font-weight: bold; color: #007bff;">${leaveInfo.annual_leave} 일</div>
            </div>
        </c:when>
        <c:otherwise>
            <div style="text-align: center; padding: 20px; border: 1px solid #eee; color: red; font-weight: bold;">
                연차 정보가 없습니다.
            </div>
        </c:otherwise>
    </c:choose>

    <h5 style="margin: 40px 0 10px; font-weight: bold; color: #2c3e50;">🏢 전체 사원 연차 정보</h5>

    <c:choose>
        <c:when test="${not empty employeeList}">
            <div style="display: grid; grid-template-columns: 1fr 2fr 1fr; font-weight: bold; background: #f9f9f9; padding: 10px; border-bottom: 2px solid #ddd;">
                <div style="text-align: center;">사원번호</div>
                <div style="text-align: center;">사원명</div>
                <div style="text-align: center;">잔여 연차</div>
            </div>
            <c:forEach var="emp" items="${employeeList}">
                <div style="display: grid; grid-template-columns: 1fr 2fr 1fr; padding: 12px 10px; border-bottom: 1px solid #eee; align-items: center;">
                    <div style="text-align: center;">${emp.emp_no}</div>
                    <div style="text-align: center;">${emp.emp_nm}</div>
                    <div style="text-align: center; font-weight: bold; color: #007bff;">${emp.annual_leave} 일</div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div style="text-align: center; padding: 20px; border: 1px solid #eee; color: red; font-weight: bold;">
                전체 사원 연차 정보가 없습니다.
            </div>
        </c:otherwise>
    </c:choose>

    <!-- 페이징 -->
    <div id="paging" style="margin-top: 20px; text-align: center;">
        ${pageInfo.pagingHtml}
    </div>

</div>
