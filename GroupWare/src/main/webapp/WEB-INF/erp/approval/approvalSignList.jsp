<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./../common/common.jsp"%>

<style>
button.open-edit-modal {
	background: none; /* 배경 제거 */
	border: none; /* 테두리 제거 */
	color: #e74c3c; /* 글자색을 a 태그와 동일하게 */
	text-decoration: none; /* 밑줄 제거 */
	cursor: pointer; /* 클릭 가능하게 */
	font-size: inherit; /* 글자 크기 유지 */
	padding: 0; /* 기본 padding 제거 */
}
button.signBtn {
	background: none; /* 배경 제거 */
	border: none; /* 테두리 제거 */
	color: #27ae60; /* 글자색을 a 태그와 동일하게 */
	text-decoration: none; /* 밑줄 제거 */
	cursor: pointer; /* 클릭 가능하게 */
	font-size: inherit; /* 글자 크기 유지 */
	padding: 0; /* 기본 padding 제거 */
}
</style>
<div id="approvalmustDoContainer">
	<div
		style="background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);">
		<h4 style="margin-bottom: 20px; text-align: center;">📝 결재 승인 목록</h4>

		<!-- 헤더 -->
		<div
			style="display: grid; grid-template-columns: repeat(12, 1fr); font-weight: bold; background: #f8f8f8; padding: 10px; border-bottom: 2px solid #ddd; text-align: center;">
			<div>결재 번호</div>
			<div>문서 번호</div>
			<div>결재 순서</div>
			<div>사원 번호</div>
			<div>부서 코드</div>
			<div>직급 코드</div>
			<div>결재 상태</div>
			<div>결재 일시</div>
			<div>반려 사유</div>
			<div>서류</div>
			<div>반려</div>
			<div>승인</div>
		</div>

		<!-- 리스트 -->
		<c:forEach var="approval" items="${getApprovalSignList}">
			<div
				style="display: grid; grid-template-columns: repeat(12, 1fr); padding: 12px 10px; border-bottom: 1px solid #eee; align-items: center; text-align: center;">
				<div>${approval.appr_no}</div>
				<div>${approval.doc_no}</div>
				<div>${approval.appr_order}</div>
				<div>${approval.emp_no}</div>
				<div>${approval.dept_cd}</div>
				<div>${approval.position_cd}</div>
				<div>${approval.appr_status}</div>
				<div>${approval.appr_dtm}</div>
				<div>${approval.appr_refuse_op}</div>
				<div>
					<a href="download.erp?doc_no=${approval.doc_no}"
						style="color: #3498db; text-decoration: none;">다운로드</a>
				</div>
				<div>
					<button class="open-edit-modal" data-url="rejectForm.erp"
						data-id="${approval.appr_no}">반려</button>
				</div>
				<button class="signBtn" data-url="signOff.erp" data-name="결재"
					data-params='{"appr_no":"${approval.appr_no}","appr_order":"${approval.appr_order}"}'>
					승인</button>
			</div>
		</c:forEach>

		<!-- 페이징 -->
		<div id="paging" style="margin-top: 20px; text-align: center;">
			${pageInfo.pagingHtml}</div>
	</div>
</div>
