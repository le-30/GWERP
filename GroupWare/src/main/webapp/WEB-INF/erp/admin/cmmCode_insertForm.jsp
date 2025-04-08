<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="./../common/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/styles/modal.css">

<div class="custom-modal-overlay">
  <div class="modal-box cmmCode-size">
    <div class="modal-header">
      <span class="modal-title">🧩 공통코드 등록</span>
      <button type="button" class="close-btn" onclick="closeModal()">✕</button>
    </div>

    <form:form commandName="cmmCodeBean" action="cmmCode_insert.erp" method="post" id="cmmCodeinsertForm">

      <div class="form-group">
        <label>코드 Class</label>
        <input type="text" name="cmm_class" value="${cmmCodeBean.cmm_class}">
      </div>
      <form:errors path="cmm_class" cssClass="err" />

      <div class="form-group">

        <label>공통 코드</label>

        <input type="text" name="cmm_cd" value="${cmmCodeBean.cmm_cd}">
      </div>
      <form:errors path="cmm_cd" cssClass="err" />

      <div class="form-group">

        <label>공통코드 이름</label>

        <input type="text" name="cmm_nm" value="${cmmCodeBean.cmm_nm}">
      </div>
      <form:errors path="cmm_nm" cssClass="err" />

      <div class="modal-footer">
        <input type="button" value="추가하기" id="submitBtn" data-modal="cmmCode_insert" class="btn btn-primary">
      </div>
    </form:form>
  </div>
</div>

<%@include file="./../js/validCheck.jsp"%>
