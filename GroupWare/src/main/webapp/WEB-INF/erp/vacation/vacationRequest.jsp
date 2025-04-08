<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="./../common/common.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/modal.css">

<!-- 모달 내부 스타일 직접 정의 -->


<script>
function validateCheckbox() {
    let vacationType = document.querySelector('input[name="vacation_type"]:checked');
    if (!vacationType) {
        alert("휴가 유형을 선택하세요.");
        return false;
    }
    return true;
}

function closeModal() {
    document.querySelector(".custom-modal-overlay").style.display = "none";
}
</script>

<!-- 모달 HTML -->
<div class="custom-modal-overlay" style="display: flex;">
	<div class="modal-box vacation-size">
		<div class="modal-header">
			<span class="modal-title">🌴 휴가 신청</span>
			<button type="button" class="close-btn" onclick="closeModal()">✕</button>
		</div>

		<form action="vacation_insert.erp" method="post" onsubmit="return validateCheckbox()">
			<input type="hidden" name="emp_no" value="${sessionScope.emp_no}">

			<!-- radio 그룹 -->
			<div class="form-group radio-group">
  				<label><input type="radio" name="vacation_type" value="연차"> 연차</label>
  				<label><input type="radio" name="vacation_type" value="반차"> 반차</label>
  				<label><input type="radio" name="vacation_type" value="병가"> 병가</label>
  				<label><input type="radio" name="vacation_type" value="기타"> 기타</label>
			</div>

			<div class="form-group">
				<label>사원 번호</label>
				<input type="text" name="req_emp_no" value="${sessionScope.emp_no}" readonly>
			</div>

			<div class="form-group">
				<label>휴가 사유</label>
				<textarea name="vacation_reason" class="form-control"></textarea>
			</div>

			<div class="form-group">
				<label>시작일</label>
				<input type="date" name="start_dt">
			</div>

			<div class="form-group">
				<label>종료일</label>
				<input type="date" name="end_dt">
			</div>

			<div class="modal-footer">
				<input type="submit" value="신청" class="btn btn-primary">
			</div>
		</form>
	</div>
</div>
