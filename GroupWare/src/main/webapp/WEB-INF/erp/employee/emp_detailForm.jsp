<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h2>사원상세정보</h2>

사원번호:${empBean.emp_no }
<br><br>
사원이름:${empBean.emp_nm }
<br><br>
상태:${empBean.emp_status_nm }
<br><br>
부서:${empBean.dept_nm }
<br><br>
직위:${empBean.position_nm }
<br><br>
입사일:${empBean.hire_date }
<br><br>
성별:${empBean.gender_nm }
<br><br>
생년월일:${empBean.birth }
<br><br>
이메일:${empBean.email }
<br><br>

<button class="open-edit-modal"
		data-url="emp_update.erp"
		data-id="${empBean.emp_no }">
		수정</button>

 <br><br>

 
<div class="sideTr" data-action="page" data-target="emp" onclick="handleSidebar(this)">
	<input type="hidden" value="${whatColumn}" name="whatColumn">
	<input type="hidden" value="${keyword}" name="keyword">
	<input type="hidden" value="${pageNumber}" name="pageNumber">
	<i class="fas fa-paper-plane sideIcon"></i>< 사원정보
</div>

