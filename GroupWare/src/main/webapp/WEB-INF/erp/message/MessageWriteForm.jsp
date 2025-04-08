<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="./../common/common.jsp"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/styles/modal.css">

<style type="text/css">
.form-group.column-group {
  display: flex;
  flex-direction: column; /* 🔥 아래로 정렬되게 함 */
  align-items: flex-start;
  margin-bottom: 15px;
}

#checkboxList {
  margin-top: 8px;
  display: flex;
  flex-direction: column;
  gap: 4px;
  padding-left: 10px;
}

.checkbox-item {
  display: flex;
  align-items: center;
  gap: 6px;
}


#toggleCheckboxList {
	background: none;
	border: none;
	cursor: pointer;
	font-size: 14px;
	padding: 0;
	color: blue;
}

.err {
	font-size: 10pt;
	color: red;
	font-weight: bold;
}
</style>
<script

	src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js">
	</script>

<div class="custom-modal-overlay"
	style="display: flex; justify-content: center; align-items: center; position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; background-color: rgba(0, 0, 0, 0.3); z-index: 9999;">

	<div class="modal-box mail-size">
		<div class="modal-header">
			<span class="modal-title">📨 메일 전송</span>
			<button type="button" class="close-btn" onclick="closeModal()">✕</button>
		</div>
		<form action="ymh_messageinsert.erp" method="post"
			id="MessageWriteForm" enctype="multipart/form-data">
			<input type="hidden" name="redirectPage" value="ymh_MessageSend.erp">
			<input type="hidden" value="${sessionScope.emp_no }"
				name="send_emp_no">
			<div>
				<div class="form-group column-group">
					<label>받는사람</label>
					<button type="button" id="toggleCheckboxList">▼ 받는 사람 선택</button>

					<!-- 요게 버튼 아래에 나오게 됨 -->
					<div id="checkboxList" style="display: none;">
						<c:forEach var="eb" items="${list}">
							<c:if test="${eb.emp_no != sessionScope.emp_no}">
								<div class="checkbox-item">
									<input type="checkbox" name="receive_emp_no"
										value="${eb.emp_no}" required> <label>${eb.emp_nm}</label>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</div>


			</div>
			<div>
				<div class="form-group">
					<label>제목</label> <input type="text" name="msg_title"
						value="${mb.msg_title }">
				</div>
			</div>

			<div>
				<div class="form-group">
					<label>내용</label>
					<textarea cols="40" rows="5" name="msg_content">${mb.msg_content }</textarea>
				</div>
			</div>

			<div>
				<div class="form-group">
					<label>첨부파일</label> <input type="file" name="file" required />
				</div>
			</div>
			<div class="modal-footer">
				<input type="button" value="메일 전송" id="submitBtn" data-modal="mail_insert" class="btn btn-primary">
			</div>
		</form>
	</div>
</div>

<%@include file="./../js/validCheck.jsp"%>