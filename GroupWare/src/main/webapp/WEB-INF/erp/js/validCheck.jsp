<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
window.formSubmitConfig = window.formSubmitConfig || {
	emp_insert: {
		url: "lsh_insert.erp",
		formId: "empinsertForm",
		defaultRedirect: "emp"
	},
	emp_update: {
		url: "emp_update.erp",
		formId: "empUpdateForm",
		defaultRedirect: "empUpdate"
	},
	dept_insert: {
		url: "dept_insert.erp",
		formId: "deptinsertForm",
		defaultRedirect: "dept"
	},
	dept_update: {
		url: "dept_update.erp",
		formId: "deptupdateForm",
		defaultRedirect: "dept"
	},
	cmmCode_insert: {
		url: "cmmCode_insert.erp",
		formId: "cmmCodeinsertForm",
		defaultRedirect: "cmmCode"
	},
	cmmCode_update: {
		url: "cmmCode_update.erp",
		formId: "cmmCodeupdateForm",
		defaultRedirect: "cmmCode"
	},
	auth_insert: {
		url: "auth_insert.erp",
		formId: "authinsertForm",
		defaultRedirect: "auth"
	},
	auth_update: {
		url: "auth_update.erp",
		formId: "authupdateForm",
		defaultRedirect: "auth"
	},
	mail_insert : {
		url : "ymh_messageinsert.erp",
		formId : "MessageWriteForm",
		target : "send",
		page : "msg", // insert 이후 헤더 움직이게 하기 위함
		userFormData: true
	},
	mail_reply : {
		url : "ymh_messageReply.erp",
		formId : "MessageReplyForm",
		target : "received",
		userFormData: true
	},
	mail_pass : {
		url : "ymh_messagePass.erp",
		formId : "MessagePassForm",
		target : "received",
	},
	notice_insert: {
		url: "notice_write.erp",
		formId: "notice_writeForm",
		target: "totalnotice",
		page : "notice",
		userFormData: true
	},
	notice_update: {
		url: "notice_update.erp",
		formId: "notice_updateform",
		target: "totalnotice",
		page : "notice",
		userFormData: true
	}
};

	$(document).off('click', '#submitBtn').on('click', '#submitBtn', function () {
		const config = formSubmitConfig[$(this).data('modal')];
		const $form = $('#' + config.formId);
		  
		const requiredFileForms = ["MessageWriteForm", "MessageReplyForm"];
		if (requiredFileForms.includes(config.formId)) {  
			const fileInput = $('input[name="file"]', $form)[0];

		if (!fileInput.files || fileInput.files.length === 0) {
			alert("파일을 첨부해야 합니다.");
			event.preventDefault(); // 폼 전송 방지
			return;
		}
	}
		  
		let formData;
	if(config.userFormData){
			  formData = new FormData($form[0]);
		  }else{
			formData = $form.serialize();  
		  }
		  

		  $.ajax({
		    url: config.url,
		    method: 'POST',
		    data: formData,
		    processData: !config.userFormData,
            contentType: config.userFormData ? false : 'application/x-www-form-urlencoded',
		    success: function (html) {
		      const $newForm = $('<div>').html(html).find('form');

		      if ($newForm.length > 0) {
		        // 유효성 실패
		        $form.replaceWith($newForm);
		      } else {
		        // 유효성 성공
		        $('#customModal').hide();
		        $('#modalContent').empty();
				
		        const redirectPage = $form.find('input[name="redirectPage"]').val();
				   const targetPage = config.target || config.defaultRedirect;
				   const page = config.page;
				
				   //alert("targetPage : " + targetPage);
				   //alert("page : " + page);
				   
		        if (redirectPage) {
		          $.ajax({
		            url: redirectPage,
		            method: 'GET',
		            success: function (html) {
		              $('.main-content').html(html);
		              handleSidebarByTarget(targetPage,page);
		            },
		            error: function () {
		              alert('리디렉션 실패');
		            }
		          });
		        }else{
		          loadContent(config.defaultRedirect); // 기본 본문 리로드
		          handleSidebarByTarget(targetPage,page);
		        	}
		        }
		      $('#submitBtn').prop('disabled', false);
              
		     
		    },
		    error: function () {
		      alert("요청 중 오류 발생");
		    }
		  });
		});
	
	$(document).off('click', '#modalContent').on('click', '#modalContent #toggleCheckboxList', function () {
	    const checkboxList = $('#checkboxList');
	    if (checkboxList.css('display') === "none") {
	        checkboxList.show();
	        $(this).html("▲ 받는 사람 선택 숨기기");
	    } else {
	        checkboxList.hide();
	        $(this).html("▼ 받는 사람 선택");
	    }
	});

</script>