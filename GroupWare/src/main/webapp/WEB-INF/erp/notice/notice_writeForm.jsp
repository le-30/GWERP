<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file=".././common/common.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/styles/modal.css">


<div class="custom-modal-overlay" style="display: flex;">
  <div class="modal-box notice-size">
    <div class="modal-header">
      <span class="modal-title">📢 공지사항 작성</span>
      <button type="button" class="close-btn" onclick="closeModal()">✕</button>
    </div>

    <form:form commandName="notice" method="post" action="notice_write.erp" id="notice_writeForm" enctype="multipart/form-data">
      <input type="hidden" name="emp_no" value="${sessionScope.emp_no}">
      <input type="hidden" name="emp_nm" value="${sessionScope.emp_nm}">

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

<script>
  // 임시저장 버튼 클릭 시 호출
  function saveNotice() {
    var form = document.getElementById("notice_writeForm");
    if (!form) {
      console.error("폼을 찾을 수 없습니다. (saveNotice)");
      return;
    }
    form.action = "notice_save.erp";
    form.submit();
  }

  // 추가하기 버튼 클릭 시 호출
  function handleSidebar() {
    var form = document.getElementById("notice_writeForm");
    if (!form) {
      console.error("폼을 찾을 수 없습니다. (handleSidebar)");
      return;
    }
    form.action = "notice_write.erp"; // 또는 필요한 경우 다른 action
    form.submit();
  }

  // 모달 닫기
  function closeModal() {
    document.getElementById("customModal").style.display = "none";
    document.getElementById("modalContent").innerHTML = "";
  }

  // DOM이 모두 로드된 후 이벤트 바인딩
  window.onload = function () {
    var submitBtn = document.getElementById("submitBtn");
    if (submitBtn) {
      submitBtn.addEventListener("click", handleSidebar);
    } else {
      console.error("submitBtn 버튼을 찾을 수 없습니다.");
    }
  };
</script>


<%@include file="./../js/validCheck.jsp"%>
