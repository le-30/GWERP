<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>  
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/styles/modal.css">
<%@include file="./../common/common.jsp" %>

<% String ctxPath = request.getContextPath(); %>

<% 
    String emp_no = (String) session.getAttribute("emp_no"); 
    String dept_cd = (String) session.getAttribute("dept_cd");
    
    System.out.println("emp_no : " +  emp_no);
    System.out.println("dept_cd : " +  dept_cd);

%>

<!-- 결제 서류 제출 폼 -->
<div class="custom-modal-overlay" style="display: flex;">
  <div class="modal-box approval-size">
    <div class="modal-header">
      <span class="modal-title">📄 결재 문서 제출</span>
      <button type="button" class="close-btn" onclick="closeModal()">✕</button>
    </div>

<form:form commandName="document" enctype="multipart/form-data" id="approval_insert" action="approval_insert.erp" method="post" >
	<input type="hidden" name="redirectPage" value="approvalList.erp">

    <!-- 문서 제목 -->
    <div class="form-group">
        <label for="doc_title" class="form-label">문서 제목</label>
        <input type="text" id="doc_title" name="doc_title" class="form-control" placeholder="문서 제목을 입력하세요" required />
    </div>

    <!-- 결제 내용 -->
    <div class="form-group">
        <label for="doc_content" class="form-label">결제 내용</label>
        <textarea id="doc_content" name="doc_content" class="form-control" placeholder="결제 내용을 작성하세요" required></textarea>
    </div>

    <!-- 첨부파일 업로드 -->
    <div class="form-group">
        <label for="attachment_file" class="form-label">첨부파일 업로드</label>
        <input type="file" id="file" name="file" class="form-control" required />
        <small class="file-info">첨부 가능한 파일 형식: PDF, DOCX, JPG, PNG</small>
    </div>

    <!-- hidden 필드로 사원 번호 전달 -->
    <input type="hidden" name="emp_no" value='${sessionScope.emp_no }'>
    
    <!-- hidden 필드로 직책 코드 전달 -->
    <input type="hidden" name="dept_cd" value='${sessionScope.dept_cd }'>

    <!-- 제출 버튼 -->

    <!-- <div class="modal-footer">
    <input type="submit" value="추가하기" class="btn btn-submit">
    </div> -->
    <div class="modal-footer">
		<input type="button" value="결재신청" id="submitBtn" data-modal="approval_insert" class="btn btn-primary">
	</div>
</form:form>
</div>
</div>
</html>

<%@include file="./../js/validCheck.jsp"%>
