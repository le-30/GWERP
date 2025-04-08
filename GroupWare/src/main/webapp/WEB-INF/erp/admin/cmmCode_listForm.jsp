<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./../common/common.jsp" %>

<div id="cmmCodeListContainer" style="background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
	<h4 style="margin-bottom: 20px;">📚 공통 코드 목록 (${totalCount})</h4>

	<!-- 검색 폼 -->
	<form id="cmmCodeSearchForm" style="display: flex; gap: 10px; align-items: center; margin-bottom: 20px;">
		<select name="whatColumn" style="padding: 6px 10px; border-radius: 6px; border: 1px solid #ccc;">
			<option value="">전체 선택</option>
			<option value="cmm_class">공통코드 class</option>
			<option value="cmm_nm">공통코드 이름</option>
		</select>
		<input type="text" name="keyword" id="cmmCodekeywordInput" placeholder="검색어 입력"
			   style="width: 200px; padding: 6px 10px; border-radius: 6px; border: 1px solid #ccc;">
		<input type="button" value="검색" id="cmmCodesearchBtn"
			   style="padding: 6px 14px; background-color: #007bff; color: white; border: none; border-radius: 6px; cursor: pointer;">
	</form>

	<!-- 목록 없는 경우 -->
	<c:if test="${empty lists}">
		<div style="text-align: center; padding: 20px; border: 1px solid #eee;">등록된 공통코드가 없습니다.</div>
	</c:if>

	<!-- 목록 있는 경우 -->
	<c:if test="${not empty lists}">
		<!-- 헤더 -->
		<div style="display: grid; grid-template-columns: 2fr 2fr 2fr 1fr 1fr; font-weight: bold; background: #f9f9f9; padding: 12px 10px; border-bottom: 2px solid #ddd; text-align: center;">
			<div>공통코드 class</div>
			<div>공통코드 코드</div>
			<div>공통코드 이름</div>
			<div>수정</div>
			<div>삭제</div>
		</div>

		<!-- 공통코드 목록 출력 -->
		<c:forEach var="cmmCode" items="${lists}">
			<div style="display: grid; grid-template-columns: 2fr 2fr 2fr 1fr 1fr; padding: 12px 10px; border-bottom: 1px solid #eee; align-items: center;">
				<div style="text-align: center;">${cmmCode.cmm_class}</div>
				<div style="text-align: center;">${cmmCode.cmm_cd}</div>
				<div style="text-align: center;">${cmmCode.cmm_nm}</div>
				<div style="text-align: center;">
					<button class="open-edit-modal"
							data-url="cmmCode_update.erp"
							data-id="${cmmCode.cmm_nm}"
							style="padding: 6px 14px; background-color: #ffc107; color: #212529; border: none; border-radius: 6px; cursor: pointer;">
						수정
					</button>
				</div>
				<div style="text-align: center;">
					<button class="deleteBtn"
							data-url="cmmCode_delete.erp"
							data-name="공통코드"
							data-params='{"cmm_cd":"${cmmCode.cmm_cd}","cmm_class":"${cmmCode.cmm_class}"}'
							style="padding: 6px 14px; background-color: #dc3545; color: white; border: none; border-radius: 6px; cursor: pointer;">
						삭제
					</button>
				</div>
			</div>
		</c:forEach>
	</c:if>

	<!-- 페이징 -->
	<div id="paging" style="margin-top: 30px; text-align: center;">
		${pageInfo.pagingHtml}
	</div>
</div>
