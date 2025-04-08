<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="./../common/common.jsp" %>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/styles/modal.css">

<div class="custom-modal-overlay"
     style="display: flex; justify-content: center; align-items: center;
            position: fixed; top: 0; left: 0; width: 100vw; height: 100vh;
            background-color: rgba(0, 0, 0, 0.3); z-index: 9999;">

  <div class="modal-box emp-size">
    <div class="modal-header">
      <span class="modal-title">👤 사원 수정</span>
      <button type="button" class="close-btn" onclick="closeModal()">✕</button>
    </div>
<form:form commandName="empBean" action="emp_update.erp" method="post" id="empUpdateForm">

<%-- <input type="hidden" name="redirectPage" value="emp_detail.erp?no=${empBean.emp_no }"> --%>
 <div class="form-group">
사원번호:<input type="text" name="emp_no" value="${empBean.emp_no}">
<form:errors path="emp_no"/>
</div>

 <div class="form-group">
이름:<input type="text" name="emp_nm" value="${empBean.emp_nm }">  
<form:errors path="emp_nm"/>
</div>

 <div class="form-group">
비밀번호:<input type="password" name="pw" value="${empBean.pw }">
<form:errors path="pw"/>
</div>

 <div class="form-group">
성별:
 <div class="form-radio-group">
<input type="radio" name="gender" value="1" <c:if test="${empBean.gender.equals('1') }">checked</c:if>>남
<input type="radio" name="gender" value="2" <c:if test="${empBean.gender.equals('2') }">checked</c:if>>여
</div>
</div>
<form:errors path="gender"/>
<div class="form-group">

부서: <select name="dept_cd">
		<option value="">선택</option>
		<option value="1100" <c:if test="${empBean.dept_cd == '1100' }">selected</c:if>>인사팀</option>
		<option value="1200" <c:if test="${empBean.dept_cd == '1200' }">selected</c:if>>경영팀</option>
		<option value="1300" <c:if test="${empBean.dept_cd == '1300' }">selected</c:if>>관리팀</option>
	</select>

	</div>
<form:errors path="dept_cd"/>
<div class="form-group">

직위: <select name="position_cd">
		<option value="">선택</option>
		<option value="4" <c:if test="${empBean.position_cd == '4' }">selected</c:if>>사원</option>
		<option value="3" <c:if test="${empBean.position_cd == '3' }">selected</c:if>>과장</option>
		<option value="2" <c:if test="${empBean.position_cd == '2' }">selected</c:if>>부장</option>
		<option value="1" <c:if test="${empBean.position_cd == '1' }">selected</c:if>>사장</option>
	</select>  

	</div>
<form:errors path="position_cd"/>

<div class="form-group">
입사일:<input type="date" name="hire_date">
</div>
<div class="form-group">
생년월일:<input type="date" name="birth">
</div>
<div class="form-group">
이메일:<input type="text" name="email" value="${empBean.email }">
</div>
<form:errors path="email"/>
<div class="modal-footer">

<button 
		id="submitBtn"
		type="button"
		class="back-form"
		data-url="emp_detail.erp"
		data-id="${empBean.emp_no }"
		data-modal="emp_update">
		수정하기</button>
</div>
</form:form>
</div>
</div>

<%@include file = "./../js/validCheck.jsp"%>