<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
.form-group.column-group {
  display: flex;
  flex-direction: column; /* 🔥 아래로 정렬되게 함 */
  align-items: flex-start;
  margin-bottom: 15px;
}

</style>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js">
	</script>
    <%@include file="./../common/common.jsp" %>  
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/styles/modal.css">
   
    <div class="custom-modal-overlay"
	style="display: flex; justify-content: center; align-items: center; position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; background-color: rgba(0, 0, 0, 0.3); z-index: 9999;">

	<div class="modal-box reject-size">
		<div class="modal-header">
			<span class="modal-title">반려 사유</span>
			<button type="button" class="close-btn" onclick="closeModal()">✕</button>
		</div>
    <form id="rejectForm" action="rejectForm.erp" method="post">
		<input type="hidden" name="redirectPage" value="router.erp?page=apprList">
        <input type="hidden" name="appr_no" value="${appr_no }">
        <div class="form-group">
        <label for="appr_refuse_op">반려 사유:</label>
        </div>
        <div class="form-group">
        <textarea name="appr_refuse_op" id="appr_refuse_op" rows="5" cols="40"></textarea><br>
        </div>
        <input type="button" value="제출" id="submitBtn" data-modal="appr_reject" class="btn btn-primary">
    </form>
   </div>
   </div>
<%@include file = "./../js/validCheck.jsp"%>