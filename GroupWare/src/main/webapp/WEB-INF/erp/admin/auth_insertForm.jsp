<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="./../common/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/styles/modal.css">

<div class="custom-modal-overlay">
  <div class="modal-box auth-size">
    <div class="modal-header">
      <span class="modal-title">🔐 권한 등록</span>
      <button type="button" class="close-btn" onclick="closeModal()">✕</button>
    </div>

    <form:form commandName="authBean" action="auth_insert.erp" method="post" id="authinsertForm">
      
      <div class="form-group">
        <label>권한코드</label>
        <input type="text" name="auth_cd" value="${authBean.auth_cd}">
      </div>
      <form:errors path="auth_cd" cssClass="err" />

      <div class="form-group">
        <label>권한 이름</label>
        <input type="text" name="auth_nm" value="${authBean.auth_nm}">
      </div>
      <form:errors path="auth_nm" cssClass="err" />

      <div class="modal-footer">
        <input type="button" value="추가하기" id="submitBtn" data-modal="auth_insert" class="btn btn-primary">
      </div>
    </form:form>
  </div>
</div>

<%@include file="./../js/validCheck.jsp"%>
