<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/styles/modal.css">
<%@include file="./../common/common.jsp"%>
<% 
    String emp_no = (String) session.getAttribute("emp_no"); 
    System.out.println("emp_no : " +  emp_no);
%>
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

<!-- 紐⑤�� HTML -->
<div class="custom-modal-overlay" style="display: flex;">
	<div class="modal-box vacation-size">
		<div class="modal-header">
			<span class="modal-title">��� �닿� ��泥�</span>
			<button type="button" class="close-btn" onclick="closeModal()">��</button>
		</div>

		<form action="vacation_insert.erp" method="post" onsubmit="return validateCheckbox()">
			<input type="hidden" name="emp_no" value="${sessionScope.emp_no}">

			<!-- radio 洹몃９ -->
			<div class="form-group radio-group">
  				<label><input type="radio" name="vacation_type" value="�곗감"> �곗감</label>
  				<label><input type="radio" name="vacation_type" value="諛�李�"> 諛�李�</label>
  				<label><input type="radio" name="vacation_type" value="蹂�媛�"> 蹂�媛�</label>
  				<label><input type="radio" name="vacation_type" value="湲고��"> 湲고��</label>
			</div>

			<div class="form-group">
				<label>�ъ�� 踰���</label>
				<input type="text" name="req_emp_no" value="${sessionScope.emp_no}" readonly>
			</div>

			<div class="form-group">
				<label>�닿� �ъ��</label>
				<textarea name="vacation_reason" class="form-control"></textarea>
			</div>

			<div class="form-group">
				<label>������</label>
				<input type="date" name="start_dt">
			</div>

			<div class="form-group">
				<label>醫�猷���</label>
				<input type="date" name="end_dt">
			</div>

			<div class="modal-footer">
				<input type="submit" value="��泥�" class="btn btn-primary">
			</div>
		</form>
	</div>
</div>
