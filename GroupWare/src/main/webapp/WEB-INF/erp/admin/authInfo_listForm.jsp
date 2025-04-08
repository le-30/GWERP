<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file=".././common/common.jsp" %>

<div id="authInfoFormContainer" style="background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
	<h4 style="margin-bottom: 20px;">👤 사원 권한 관리 (${totalCount})</h4>

	<!-- 검색 폼 -->
	<form id="authInfoSearchForm" style="margin-bottom: 20px; display: flex; gap: 10px; align-items: center;">
		<select name="whatColumn" style="padding: 6px 10px; border-radius: 6px; border: 1px solid #ccc;">
			<option value="">전체 선택</option>
			<option value="emp_nm">사원이름</option>
			<option value="dept_nm">부서이름</option>
		</select>
		<input type="text" name="keyword" id="authInfoKeywordInput" placeholder="검색어 입력"
			   style="width: 200px; padding: 6px 10px; border-radius: 6px; border: 1px solid #ccc;">
		<input type="button" value="검색" id="authInfSearchBtn"
			   style="padding: 6px 14px; border-radius: 6px; background-color: #007bff; color: white; border: none; cursor: pointer;">
	</form>

	<!-- 권한 부여 폼 -->
	<form action="empAuthInfo.erp" method="post">

		<!-- 부여할 권한 선택 -->
		<div style="margin-bottom: 20px;">
			<label for="auth_cd"><strong>부여할 권한:</strong></label>
			<select name="auth_cd" style="margin-left: 10px; padding: 6px 10px; border-radius: 6px; border: 1px solid #ccc;">
				<c:forEach var="auth" items="${authList}">
					<option value="${auth.auth_cd}">${auth.auth_nm}</option>
				</c:forEach>
			</select>
		</div>

		<!-- 목록 없는 경우 -->
		<c:if test="${empty empList}">
			<div style="text-align: center; padding: 20px; border: 1px solid #eee;">조회된 사원이 없습니다.</div>
		</c:if>

		<!-- 목록 있는 경우 -->
		<c:if test="${not empty empList}">
			<!-- 헤더 -->
			<div style="display: grid; grid-template-columns: 0.5fr 1fr 1fr 1fr 1fr 1fr; font-weight: bold; background: #f9f9f9; padding: 12px 10px; border-bottom: 2px solid #ddd; text-align: center;">
				<div>선택</div>
				<div>사원번호</div>
				<div>이름</div>
				<div>부서명</div>
				<div>직위</div>
				<div>현재 권한</div>
			</div>

			<!-- 사원 목록 -->
			<c:forEach var="emp" items="${empList}">
				<div style="display: grid; grid-template-columns: 0.5fr 1fr 1fr 1fr 1fr 1fr; padding: 12px 10px; border-bottom: 1px solid #eee; align-items: center;">
					<div style="text-align: center;">
						<input type="checkbox" name="emp_no" value="${emp.emp_no}" />
					</div>
					<div style="text-align: center;">${emp.emp_no}</div>
					<div style="text-align: center;">${emp.emp_nm}</div>
					<div style="text-align: center;">${emp.dept_nm}</div>
					<div style="text-align: center;">${emp.position_nm}</div>
					<div style="text-align: center;">${emp.currentAuth}</div>
				</div>
			</c:forEach>
		</c:if>

		<!-- 버튼 영역 -->
		<div style="margin-top: 20px; display: flex; gap: 10px;">
			<input type="button" id="grantBtn" value="권한 부여"
				   style="padding: 8px 16px; background-color: #28a745; color: white; border: none; border-radius: 6px; cursor: pointer;" />
			<input type="button" id="revokeBtn" value="권한 해제"
				   style="padding: 8px 16px; background-color: #dc3545; color: white; border: none; border-radius: 6px; cursor: pointer;" />
		</div>

		<!-- 페이징 -->
		<div id="paging" style="margin-top: 30px; text-align: center;">
			${pageInfo.pagingHtml}
		</div>
	</form>
</div>
