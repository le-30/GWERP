<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="./../common/common.jsp" %>



<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/styles/modal.css">

<div class="custom-modal-overlay">
  <div class="modal-box auth-size">
    <div class="modal-header">
      <span class="modal-title">🔐 권한 수정</span>
      <button type="button" class="close-btn" onclick="closeModal()">✕</button>
    </div>
<form:form commandName="authInfoBean" action="auth_update.erp" method="post" id="authupdateForm">
 <input type="hidden" name="redirectPage" value="auth_list.erp?auth_cd=${authInfoBean.auth_cd}">
 
 <div class="form-group">
        <label>권한코드</label>
        <input type="text" name="auth_cd" value="${authInfoBean.auth_cd}">
      </div>
      <form:errors path="auth_cd" cssClass="err" />

      <div class="form-group">
        <label>권한 이름</label>
        <input type="text" name="auth_nm" value="${authInfoBean.auth_nm}">
      </div>
      <form:errors path="auth_nm" cssClass="err" />
<div class="modal-footer">

<button 
		id="submitBtn"
		type="button"
		class="back-form"
		data-url="auth_update.erp"

		data-id="${authInfoBean.auth_cd}"
		data-modal="auth_update">
		수정하기</button>
		</div>
</form:form>
</div>
</div>

<%@include file = "./../js/validCheck.jsp"%>