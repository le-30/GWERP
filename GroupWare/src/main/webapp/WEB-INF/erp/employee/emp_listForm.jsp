<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@include file="./../common/common.jsp" %>

<form id="empSearchForm" style="margin-bottom: 20px; display: flex; gap: 10px; align-items: center;">
  <select name="whatColumn" style="padding: 5px;">
    <option value="">전체 선택</option>
    <option value="emp_no">사원번호</option>
    <option value="emp_nm">사원이름</option>
  </select>

  <input type="text" name="keyword" id="empKeywordInput" placeholder="검색어 입력" style="padding: 5px;">
  <input type="button" value="검색" id="empSearchBtn" style="padding: 6px 12px;">
</form>

<div id="empListContainer" style="background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
  <div style="display: grid; grid-template-columns: 1.5fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1.5fr; background: #f9f9f9; padding: 10px; font-weight: bold; border-bottom: 2px solid #ddd;">
    <div>이름</div>
    <div>상태</div>
    <div>사번</div>
    <div>입사일</div>
    <div>직위</div>
    <div>부서</div>
    <div>성별</div>
    <div>생년월일</div>
    <div>이메일</div>
  </div>
  <c:forEach var="emp" items="${lists}">
    <div style="display: grid; grid-template-columns: 1.5fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1.5fr; padding: 12px 10px; border-bottom: 1px solid #eee; align-items: center;">
      <div>
        <a href="javascript:void(0)" onclick="Detail('${emp.emp_no},${pageInfo.pageNumber },${pageInfo.whatColumn },${pageInfo.keyword }', 'emp')" style="color: #333; text-decoration: none; font-weight: 500;">
          ${emp.emp_nm}
        </a>
      </div>
      <div>
        <span style="background: #28a745; color: white; padding: 2px 6px; border-radius: 8px; font-size: 12px;">
          ${emp.emp_status_nm}
        </span>
      </div>
      <div>${emp.emp_no}</div>
      <div><fmt:formatDate value="${emp.hire_date}" pattern="yyyy-MM-dd"/></div>
      <div>${emp.position_nm}</div>
      <div>${emp.dept_nm}</div>
      <div>${emp.gender_nm}</div>
      <div><fmt:formatDate value="${emp.birth}" pattern="yyyy-MM-dd"/></div>
      <div>${emp.email}</div>
    </div>
  </c:forEach>

  <div id="paging" style="margin-top: 20px; text-align: center;">
    ${pageInfo.pagingHtml}
  </div>
</div>