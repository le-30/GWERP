<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="./../common/common.jsp" %>

<div id="deptListContainer">
	<div id="deptListWrapper" style="background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
		<h4 style="margin-bottom: 20px;">🏢 부서 목록 (${totalCount})</h4>
  
		<!-- 검색 폼 -->
		<form id="deptSearchForm" style="margin-bottom: 20px; display: flex; gap: 10px; align-items: center;">
			<select name="whatColumn" style="padding: 6px 10px; border-radius: 6px; border: 1px solid #ccc;">
				<option value="">전체 선택</option>
				<option value="dept_cd">부서코드</option>
				<option value="dept_nm">부서이름</option>
			</select>
			<input type="text" name="keyword" id="deptkeywordInput" placeholder="검색어 입력"
				   style="width: 200px; padding: 6px 10px; border-radius: 6px; border: 1px solid #ccc;">
			<input type="button" value="검색" id="deptSearchBtn"
				   style="padding: 6px 14px; border-radius: 6px; background-color: #007bff; color: white; border: none; cursor: pointer;">
		</form>

		<!-- 부서 목록 없는 경우 -->
		<c:if test="${empty lists}">
			<div style="text-align: center; padding: 20px; border: 1px solid #eee;">등록된 부서가 없습니다.</div>
		</c:if>

		<!-- 부서 목록 있는 경우 -->
		<c:if test="${not empty lists}">
			<!-- 헤더 -->
			<div style="display: grid; grid-template-columns: 1fr 2fr 2fr 1fr; font-weight: bold; background: #f9f9f9; padding: 12px 10px; border-bottom: 2px solid #ddd; text-align: center;">
				<div>부서코드</div>
				<div>부서이름</div>
				<div>상위부서코드</div>
				<div>수정</div>
			</div>

			<!-- 부서 목록 출력 -->
			<c:forEach var="dept" items="${requestScope.lists}">
				<div style="display: grid; grid-template-columns: 1fr 2fr 2fr 1fr; padding: 12px 10px; border-bottom: 1px solid #eee; align-items: center;">
					<div style="text-align: center;">${dept.dept_cd}</div>
					<div style="text-align: center;">${dept.dept_nm}</div>
					<div style="text-align: center;">${dept.p_dept_cd}</div>
					<div style="text-align: center;">
						<button class="open-edit-modal"
								data-url="dept_update.erp"
								data-id="${dept.dept_cd}"
								style="padding: 6px 14px; background-color: #ffc107; border: none; color: #212529; border-radius: 6px; cursor: pointer;">
							수정
						</button>
					</div>
				</div>
			</c:forEach>
		</c:if>

		<!-- 페이징 -->
		<div id="paging" style="margin-top: 20px; text-align: center;">
			${pageInfo.pagingHtml}
		</div>
	</div>
</div>
