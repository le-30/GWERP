<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="./../common/common.jsp" %>


<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/styles/modal.css">
<style>
style type="text/css">
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
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script>
	
	document.getElementById('toggleCheckboxList').addEventListener('click', function() {
	    var checkboxList = document.getElementById('checkboxList');
	    if (checkboxList.style.display === "none") {
	        checkboxList.style.display = "block";
	        this.innerHTML = "▲ 받는 사람 선택 숨기기";
	    } else {
	        checkboxList.style.display = "none";
	        this.innerHTML = "▼ 받는 사람 선택";
	    }
	});

</script>

<div class="custom-modal-overlay"
	style="display: flex; justify-content: center; align-items: center; position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; background-color: rgba(0, 0, 0, 0.3); z-index: 9999;">

	<div class="modal-box mail-size">
		<div class="modal-header">
			<span class="modal-title">📨 메일 전달</span>
			<button type="button" class="close-btn" onclick="closeModal()">✕</button>
		</div>

<form:form action="ymh_messageinsert.erp" commandName="mb" method="post" id="MessagePassForm">
	<input type="hidden" value="${sessionScope.emp_no }" name="send_emp_no">
	<input type="hidden" value="${mb.msg_no }" name="msg_no">
	<input type="hidden" name="redirectPage" value="messageDetail.erp?no=${mb.msg_no }">
    <div>

        <div class="form-group column-group">

            <!-- 화살표 버튼을 누르면 체크박스 목록이 나타남 -->
            <label>받는사람</label>
	            <form:errors cssClass="err" path="receive_emp_no"/>
            <br>
            <button type="button" id="toggleCheckboxList">▼ 받는 사람 선택</button>
            <div id="checkboxList" style="display:none;">
                <c:forEach var="eb" items="${list}">
                	<c:if test="${eb.emp_no != sessionScope.emp_no}">
                        <div>
                            <input type="checkbox" name="receive_emp_no" value="${eb.emp_no}">
                            <label>${eb.emp_nm}</label>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </div>
    <div>

        <div class="form-group">

            <label>제목</label>
            <input type="text" name="msg_title" value="${mb.msg_title }" readonly>
        </div>
    </div>
   
    <div>

        <div class="form-group">

            <label>내용</label>
            <textarea cols="40" rows="5" name="msg_content" readonly>${mb.msg_content }</textarea>
        </div>
    </div>
    
    <div>

		<div class="form-group">
			<label>${attach2.org_file_name }</label>	
		</div>
	</div>
	<div class="modal-footer">
	<input type="button" value="메일 전송" id="submitBtn" data-modal="mail_pass">
	</div>
</form:form>
</div>
</div>


<%@include file = "./../js/validCheck.jsp"%>