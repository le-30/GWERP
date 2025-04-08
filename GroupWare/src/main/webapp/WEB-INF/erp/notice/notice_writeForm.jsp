<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file=".././common/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/styles/modal.css">

<script>
    function saveNotice() {
        var form = document.getElementById("notice_writeForm");
        form.action = "notice_save.erp";
        form.submit();
    }

    function closeModal() {
        document.getElementById("customModal").style.display = "none";
        document.getElementById("modalContent").innerHTML = "";
    }
</script>

<div class="custom-modal-overlay" style="display: flex;">
  <div class="modal-box notice-size">
    <div class="modal-header">
      <span class="modal-title">📢 공지사항 작성</span>
      <button type="button" class="close-btn" onclick="closeModal()">✕</button>
    </div>

    <form:form commandName="notice" method="post" action="notice_write.erp" id="notice_writeForm" enctype="multipart/form-data">
      <input type="hidden" name="emp_no" value="${sessionScope.emp_no}">
      <input type="hidden" name="emp_nm" value="${sessionScope.emp_nm}">

      <input type="hidden" name="redirectPage" value="notice_mlist.erp">

      <div class="form-group">
        <label for="dept_nm">부서선택</label>
        <select name="dept_nm" id="dept_nm" class="form-control">
          <option value="전체">전체</option>
          <option value="${sessionScope.dept_nm}">${sessionScope.dept_nm}</option>
        </select>
        <label style="margin-left: 10px;">
          <input type="checkbox" name="notice_level" value="1"> 필독
        </label>
      </div>

      <div class="form-group">
        <label for="notice_title">제목</label>
        <input type="text" name="notice_title" value="${notice.notice_title}" class="form-control">
        <form:errors cssClass="err" path="notice_title"/>
      </div>

      <div class="form-group">
        <label for="file">파일첨부</label>
        <input type="file" name="file" class="form-control">
        <small style="color: red;">* 첨부파일 임시저장 불가</small>
      </div>

      <div class="form-group">
        <label for="notice_content">내용</label>
        <textarea name="notice_content" class="form-control" rows="18"
          style="width: 100%; min-height: 300px; resize: vertical;">${notice.notice_content}</textarea>
      </div>

      <div class="modal-footer">
        <input type="button" value="임시저장" onclick="saveNotice()" class="btn btn-secondary">
        <input type="button" value="추가하기" id="submitBtn" data-modal="notice_insert" class="btn btn-primary">
      </div>
    </form:form>
  </div>
</div>


<%@include file="./../js/validCheck.jsp"%>
