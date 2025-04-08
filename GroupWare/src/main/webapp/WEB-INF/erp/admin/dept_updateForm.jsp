<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="./../common/common.jsp" %>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/styles/modal.css">

<div class="custom-modal-overlay">
  <div class="modal-box dept-size">
    <div class="modal-header">
      <span class="modal-title">🏢 부서 수정</span>
      <button type="button" class="close-btn" onclick="closeModal()">✕</button>
    </div>
<form:form commandName="deptBean" action="dept_update.erp" method="post" id="deptupdateForm">

<input type="hidden" name="redirectPage" value="router.erp?page=dept">

  <div class="form-group">
        <label>부서코드</label>
        <input type="text" name="dept_cd" value="${deptBean.dept_cd}" readonly>
      </div>
      <form:errors path="dept_cd" cssClass="err" />

      <div class="form-group">
        <label>부서이름</label>
        <input type="text" name="dept_nm" value="${deptBean.dept_nm}">
      </div>
      <form:errors path="dept_nm" cssClass="err" />

      <div class="form-group">
        <label>상위부서</label>
        <select name="p_dept_cd">
          <option value="">선택</option>
          <c:forEach var="dept" items="${lists}">
            <option value="${dept.dept_cd}" <c:if test="${dept.dept_cd == deptBean.p_dept_cd}">selected</c:if>>
              ${dept.dept_cd}
            </option>
          </c:forEach>
        </select>
      </div>

<div class="modal-footer">

<button 
		id="submitBtn"
		type="button"
		class="back-form"
		data-url="dept_update.erp"
		data-id="${deptBean.dept_cd}"
		data-modal="dept_update">
		수정하기</button>

</div>
</form:form>
</div>
</div>


<%@include file = "./../js/validCheck.jsp"%>