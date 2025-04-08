<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file=".././common/common.jsp" %>

<div id="authListContainer" style="background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
	<h4 style="margin-bottom: 20px;">🔐 권한 목록 (${totalCount})</h4>

	<!-- 검색 폼 -->
	<form id="authSearchForm" style="margin-bottom: 20px; display: flex; gap: 10px; align-items: center;">
		<select name="whatColumn" style="padding: 6px 10px; border-radius: 6px; border: 1px solid #ccc;">
			<option value="">전체 선택</option>
			<option value="auth_cd">권한코드</option>
			<option value="auth_nm">권한이름</option>
		</select>
		<input type="text" name="keyword" id="authKeywordInput" placeholder="검색어 입력"
			   style="width: 200px; padding: 6px 10px; border-radius: 6px; border: 1px solid #ccc;">
		<input type="button" value="검색" id="authSearchBtn"
			   style="padding: 6px 14px; border-radius: 6px; background-color: #007bff; color: white; border: none; cursor: pointer;">
	</form>

	<!-- 목록 없는 경우 -->
	<c:if test="${empty authList}">
		<div style="text-align: center; padding: 20px; border: 1px solid #eee;">등록된 권한이 없습니다.</div>
	</c:if>

	<!-- 목록 있는 경우 -->
	<c:if test="${not empty authList}">
		<!-- 헤더 -->
		<div style="display: grid; grid-template-columns: 1fr 3fr 1fr 1fr; font-weight: bold; background: #f9f9f9; padding: 12px 10px; border-bottom: 2px solid #ddd; text-align: center;">
			<div>권한 코드</div>
			<div style="text-align: left;">권한 이름</div>
			<div>수정</div>
			<div>삭제</div>
		</div>

		<!-- 권한 목록 출력 -->
		<c:forEach var="auth" items="${authList}">
			<div style="display: grid; grid-template-columns: 1fr 3fr 1fr 1fr; padding: 12px 10px; border-bottom: 1px solid #eee; align-items: center;">
				<div style="text-align: center;">${auth.auth_cd}</div>
				<div style="text-align: left;">${auth.auth_nm}</div>
				<div style="text-align: center;">
					<button class="open-edit-modal"
							data-url="auth_update.erp"
							data-id="${auth.auth_cd}"
							style="padding: 6px 14px; background-color: #ffc107; border: none; color: #212529; border-radius: 6px; cursor: pointer;">
						수정
					</button>
				</div>
				<div style="text-align: center;">
					<button class="deleteBtn"
							data-url="auth_delete.erp"
							data-name="권한관리"
							data-params='{"auth_cd":"${auth.auth_cd}"}'
							style="padding: 6px 14px; background-color: #dc3545; border: none; color: white; border-radius: 6px; cursor: pointer;">
						삭제
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
