<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 본문,헤더버튼 관리 페이지 -->
<script>


window.pageConfig = window.pageConfig || {
	emp: {
		button: "사원 등록",
		modal: "emp_insert",
		auth :"관리자권한,사원등록권한",
		container:"empListContainer",
		tabs: [
			{ label: "사원 목록", target: "emp" }
			]
		},
	dept: {
		button: "부서등록",
		modal: "dept_insert",
		container:"deptListContainer",
		tabs: [
			{ label: "부서관리", target: "dept" }
			]
		},
	cmmCode: {
		button: "공통코드등록",
		modal: "cmmCode_insert",
		container:"cmmCodeListContainer",
		tabs: [
			{ label: "공통코드 관리", target: "cmmCode" }
			]
	},
	authInfo: {
		button: "권한등록",
		modal: "authInfo_insert",
		container:"authInfoListContainer",
		tabs: [
			{ label: "권한부여 관리", target: "authInfo" }
			]
    },

	auth: {
		button: "권한등록",
		modal: "auth_insert",
		container:"authListContainer",
		tabs: [
			{ label: "권한관리", target: "auth" }
			]
    },
	received: {
		button: "메일 보내기",
		modal: "mail_insert",
		container:"msgReceiveListContainer",
		tabs: [
			{ label: "받은 쪽지", target: "received" }
			]
	 },
	send: {
		button: "메일 보내기",
		modal: "mail_insert",
		container:"msgSendListContainer",
		tabs: [
			{ label: "보낸 쪽지", target: "send" }
			]
	},
	totalNotice: {
		button: "공지사항 작성",
		modal: "notice_insert",
		auth :"관리자권한,공지사항등록권한",
		container:"anoticeListContainer",
		tabs: [
			{ label: "전체 공지", target: "totalNotice" }
			]
	},
	deptNotice: {
		button: "공지사항 작성",
		modal: "notice_insert",
		auth :"관리자권한,공지사항등록권한",
		container:"dnoticeListContainer",
		tabs: [
			{ label: "부서 공지", target: "deptNotice" }
			]
	},
	myNotice: {
		button: "공지사항 작성",
		modal: "notice_insert",
		auth :"관리자권한,공지사항등록권한",
		container:"mnoticeListContainer",
		tabs: [
			{ label: "내가 쓴 공지", target: "myNotice" }
			]
	},
	appr: {
		button: "결제 신청",
		modal: "appr_insert",
		container:"approvalRequestContainer",
		tabs: [
			{ label: "결제 관리", target: "appr" }
			]
	},
	apprSuc: {
		container:"approvalCompleteContainer",
		tabs: [
			{ label: "본인 결재 완료 이력", target: "apprSuc" }
			]
	},
	apprList: {
		container:"approvalmustDoContainer",
		tabs: [
			{ label: "결제 해야 하는 리스트", target: "apprList" }
			]
	},
    vacation: {
	      button: "휴가 신청",
	      modal: "vacation_insert",
	      container:"vacationContainer",
	      tabs: [
	        { label: "휴가 관리", target: "vacation" }
	      ]
	    },
	    commute: {
		      button: "",
		      modal: "",
		      container:"commuteListContainer",
		      tabs: [
		        { label: "출퇴근 기록", target: "commute" }
		      ]
		    },
	salary: {
		      button: "",
		      modal: "",
		      tabs: [
		    	  { label: "급여 내역", target: "salary" }
		      ]
		    }
};//본문을 헤더에 연결할 tabs 변수, button이름 & modal 연결할 url변수 설정을 위한 변

	

	window.modalPages = window.modalPages || {
		emp_insert: 'lsh_insert.erp',
		dept_insert: 'dept_insert.erp',
		cmmCode_insert: 'cmmCode_insert.erp',
		authInfo_insert: 'authInfo_insert.erp',
		auth_insert: 'auth_insert.erp',
		mail_insert: 'ymh_messageinsert.erp',
		notice_insert: 'notice_write.erp',
		appr_insert : 'approval_insert.erp',
		vacation_insert : 'vacation_insert.erp'
			};//modal을 열면서 연결될 .erp 설정


	window.currentModal = '';
	window.currentPage ='';


		
	function loadContent(page, params = {}) {
		currentPage = page;
		let data = { page: page };
		Object.assign(data, params);
		$.ajax({
			url: 'router.erp',
			type: 'GET',
			data: data,
			success: function (html) {
				$('.main-content').html(html);

				const config = pageConfig[page];
				if (config) {
					// 버튼 텍스트와 모달 지정
					$('#headerBtn').text(config.button || '');
					currentModal = config.modal || '';

					// 버튼 숨김/보임 처리
					if (!config.button) {
						// 버튼 자체가 정의되지 않은 경우
						$('#headerBtn').hide();
					} else if (config.auth) {
						// 권한 확인 필요
						const requiredAuths = config.auth.split(",");
						const userAuths = window.userAuths || [];
						let hasPermission = false;

						for (let i = 0; i < requiredAuths.length; i++) {
							for (let j = 0; j < userAuths.length; j++) {
								if (requiredAuths[i].trim() === userAuths[j].trim()) {
									hasPermission = true;
									break;
								}
							}
							if (hasPermission) break;
						}

						$('#headerBtn').toggle(hasPermission);
					} else {
						// 권한 체크 필요 없으면 무조건 보여줌
						$('#headerBtn').show();
					}
				} else {
					// config가 없는 경우
					$('#headerBtn').text('');
					currentModal = '';
					$('#headerBtn').hide();
				}
		
				if (page === 'authInfo') {
					bindAuthorityEvents();
				}
			
				bindDeleteEvent(); // 삭제 이벤트 바인딩
				bindSignAppr();//승인이벤트 바인딩
			
			},
			error: function () {
				alert('본문을 불러오는 중 오류가 발생했습니다.');
			}
		});
	}

	
	
	
	function bindTabEvents(){
		
		$(".tab").off("click").on("click",function(){
			$(".tab").removeClass("active");
			$(this).addClass("active");
			
			const targetPage = $(this).data("target");
			if(targetPage){
				loadContent(targetPage);
			}
		});
	}//tab 클릭시 페이지교체(헤더제목 누를시)
	
	
	
	function handleSidebarByTarget(target,page) { // validCheck
		
		
		
		const sidebarBtn = $(".sideTr").filter(function() {
			return $(this).data("target") === page;
		});
		
		//alert("sidebarBtn : " + sidebarBtn.length);
		//alert('action : ' +sidebarBtn[0].dataset.action);
		//alert('target : ' +sidebarBtn[0].dataset.target);
		
		if (sidebarBtn.length > 0) {
			handleSidebar(sidebarBtn[0], target); // DOM 요소로 변환 후 전달
		} else {
			loadContent(target || page);
			/* alert("해당 target을 가진 sidebarBtn을 찾을 수 없습니다."); */
		}
		handleSidebar(sidebarBtn);
	} // insert 이후 헤더 자동 변환
	
	
	
	window.onload = function() {//"초기화 역할" + "URL 진입 대응" + "자동 탭/본문 로딩"
		const params = new URLSearchParams(window.location.search); 
		const page = params.get("page");                            
		//url에서 page=emp 같은 값을 추출
		  
		if (page && pageConfig[page]) {//page가 pageConfig에 정의되어있는지 확인
			const config = pageConfig[page];
			
		    // 탭 자동 구성
			if (config.tabs) {
				const $headerTabs = $("#headerTabs");
				$headerTabs.empty();

				$.each(config.tabs, function (index, tab) {
					const isActive = index === 0 ? "active" : "";
					const html = '<span class="tab '+isActive+ '"data-target="'+tab.target+'">'+tab.label+'</span>';
					$headerTabs.append(html);
					});

				bindTabEvents();
				loadContent(config.tabs[0].target);
			}
		    
		}else{
			loadContent(page);    
		}
	};
		
	
	$(document).ready(function () {
		$(".sideTr").on("click", function () {
			handleSidebar(this);
		});
	});
			
	
	
	$(document).ready(function () {
		console.log("검색함수 실행")
		function performSearch(formId) {
		const searchData = $(formId).serialize();
		console.log("📦 검색 데이터:", searchData);
		
		let url;
        if (formId === '#empSearchForm') {
            url = 'lsh_list.erp';
        } else if (formId === '#receiveSearchForm') {
            url = 'ymh_MessageReceive.erp';
        } else if (formId === '#sendSearchForm'){
            url = 'ymh_MessageSend.erp';  // 기본 URL
        } else if (formId === '#deptSearchForm'){
            url = 'dept_list.erp';
        }else if (formId === '#cmmCodeSearchForm'){
            url = 'cmm_list.erp';
        }else if (formId === '#authInfoSearchForm'){
            url = 'empAuthInfo.erp';
        }else if (formId === '#authSearchForm'){
            url = 'auth_list.erp';
        }else if (formId === '#notice_aSearchForm'){
            url = 'notice_alist.erp';
        }else if (formId === '#notice_dSearchForm'){
            url = 'notice_dlist.erp';
        }else if (formId === '#notice_mSearchForm'){
            url = 'notice_mlist.erp';
        }else if (formId === '#salarySearchForm'){
            url = 'salary/list.erp';

        }else if (formId === '#commuteSeaarchForm'){
            url = 'list/commute.erp';

        }
        
			$.ajax({
				url: url,
				method: 'GET',
				data: searchData,
				success: function (html) {
					$('.main-content').html(html);
				},
				error: function () {
					alert('검색 실패');
				}
			});
		}

		function addSearchEventListener(formId, searchBtnId, keywordInputId) {
	        // 검색 버튼 클릭 이벤트
	        $(document).on('click', searchBtnId, function () {
	            performSearch(formId);
	        });

	        // 폼 제출 이벤트
	        $(document).on('submit', formId, function (e) {
	            e.preventDefault();  // 기본 폼 제출 방지
	            performSearch(formId);
	        });

	        // 키보드 Enter 키 눌렀을 때 검색
	        $(document).on('keydown', keywordInputId, function (e) {
	            if (e.key === 'Enter') {
	                e.preventDefault();  // 기본 Enter 동작 방지
	                performSearch(formId);
	            }
	        });
	    }

	    // empSearchForm에 대해 이벤트 추가
	    addSearchEventListener('#empSearchForm', '#empSearchBtn', '#empKeywordInput');
	    // msgSearchForm에 대해 이벤트 추가
	    addSearchEventListener('#receiveSearchForm', '#receiveSearchBtn', '#receiveKeywordInput');
	    addSearchEventListener('#sendSearchForm', '#sendSearchBtn', '#sendKeywordInput');
	    addSearchEventListener('#authInfoSearchForm', '#authInfoSearchBtn', '#authInfoKeywordInput');
	    addSearchEventListener('#cmmCodeSearchForm', '#cmmCodeSearchBtn', '#cmmCodekeywordInput');
	    addSearchEventListener('#deptSearchForm', '#deptSearchBtn', '#deptkeywordInput');
	    addSearchEventListener('#authSearchForm', '#authSearchBtn', '#authkeywordInput');
	    addSearchEventListener('#notice_aSearchForm', '#notice_aSearchBtn', '#notice_akeywordInput');
	    addSearchEventListener('#notice_dSearchForm', '#notice_dSearchBtn', '#notice_dkeywordInput');
	    addSearchEventListener('#notice_mSearchForm', '#notice_mSearchBtn', '#notice_mkeywordInput');
	    addSearchEventListener('#salarySearchForm', '#salarySearchBtn', '#salaryKeywrodInput');
	    addSearchEventListener('#commuteSeaarchForm', '#commuteSearchBtn', '#commutekeywordInput');

	});//검색 클릭이나 엔터 누를식 본문만 바뀌는 함수


	
			
	$(document).on('click', '#paging a', function(e) {
		e.preventDefault(); // 기본 페이지 이동 막기

		const url = $(this).attr('href');
		const targetId = pageConfig[currentPage]?.container;
		const $target = $('#'+targetId);
		$.ajax({
			url: url,
			method: 'GET',
			success: function(html) {
				console.log("✅ AJAX 응답 성공!");
				const $html = $('<div>').html(html);
				const newList = $html.find('#'+targetId).html();

				if (!newList) {
					console.warn("⚠️ newList를 못 찾음. HTML 구조 이상할 수 있음");
					console.log("👉 받은 html: ", html);
					console.log("👉 찾으려는 ID:", targetId);
				}
				$target.html(newList);
    		},
    		error: function(xhr) {
    			console.log("❌ 페이징 실패", xhr.status);
    		}
    	});
	});//페이징 클릭시 본문만 바뀌는함수
		
	
	function Detail(detail, source) { // detail
	    		
  		const params = detail.split(',');
  		const no = params[0]; // msg_no는 첫 번째 값
		const pageNumber = params[1]; // pageNumber는 두 번째 값
		const whatColumn = params[2]; // whatColumn은 세 번째 값
		const keyword = params[3]; // keyword는 네 번째 값
		const kind = params[4];
		
		let url = '';
	    
	    if (source === 'message') {  
	        url = 'messageDetail.erp';
	    } else if (source === 'emp') {
	        url = 'emp_detail.erp';
	    } else if (source === 'notice') {
	        url = 'notice_content.erp';
	    } 
	    else {
	        console.log("기본 메시지 상세 조회");
	    }
		$.ajax({
			url: url,  // 서버에서 메세지 상세 정보를 처리할 URL
			type: 'GET',
			data: { 
				no: no, 
				pageNumber: pageNumber, 
				whatColumn: whatColumn, 
				keyword: keyword, 
				kind: kind
			},  // 메세지 ID를 서버로 전달
			success: function(html) {
				$('.main-content').html(html);  // 가져온 HTML을 main-content에 삽입
			},
				error: function() {
					alert('메세지 로딩 중 오류가 발생했습니다.');
				}
		});
	} // loadMessageDetail
	
	
	function noticeUpdate(update, source) { // detail
	    		
  		const params = update.split(',');
  		const no = params[0]; // msg_no는 첫 번째 값
		const pageNumber = params[1]; // pageNumber는 두 번째 값
		const whatColumn = params[2]; // whatColumn은 세 번째 값
		const keyword = params[3]; // keyword는 네 번째 값
		const kind = params[4];
		
		let url = '';
	    
		var formData = new FormData($('#notice_updateform')[0]); // notice_updateform 폼의 모든 데이터를 가져옴
		formData.append("no", no);  // 추가로 no 파라미터도 포함
		
	    if (source === 'notice') {  
	        url = 'notice_update.erp';
	    } else {
	        console.log("기본 메시지 상세 조회");
	    }
		$.ajax({
			url: url,  // 서버에서 메세지 상세 정보를 처리할 URL
			type: 'POST',
			data: formData,
	        processData: false,  // jQuery가 데이터를 처리하지 않도록 설정
	        contentType: false,  // content-type을 자동으로 설정하지 않도록 설정
			success: function(html) {
				$('.main-content').html(html);  // 가져온 HTML을 main-content에 삽입
			},
				error: function() {
					alert('메세지 로딩 중 오류가 발생했습니다.');
				}
		});
	} // notice_update
	
	
	
	function updateList(detail, kind) { // detail 목록보기
		
  		const params = detail.split(',');
		const pageNumber = params[0]; // pageNumber는 두 번째 값
		const whatColumn = params[1]; // whatColumn은 세 번째 값
		const keyword = params[2]; // keyword는 네 번째 값
		
		let url = '';
	    
	    if (kind.trim() === 'total') {  
	        url = 'notice_alist.erp';
	    } else if (kind.trim() === 'dept') {
	        url = 'notice_dlist.erp';
	    } else if (kind.trim() === 'my') {
	        url = 'notice_mlist.erp';
	    } else {
	        console.log("기본 메시지 상세 조회");
	    }
		$.ajax({
			url: url,  // 서버에서 메세지 상세 정보를 처리할 URL
			type: 'GET',
			data: { 
				pageNumber: pageNumber, 
				whatColumn: whatColumn, 
				keyword: keyword, 
				kind: kind.trim()
			},  // 메세지 ID를 서버로 전달
			success: function(html) {
				$('.main-content').html(html);  // 가져온 HTML을 main-content에 삽입
			},
				error: function() {
					alert('메세지 로딩 중 오류가 발생했습니다.');
				}
		});
	} // loadMessageDetail
	
	
	
	function writeReply() {
		var form = document.getElementById("norice_write_reply"); // 폼 가져오기
		var formData = new FormData(form); // 폼 데이터를 FormData로 변환
		
		$.ajax({
	        url: 'reply_write.erp',  // 서버에서 처리할 URL
	        type: 'POST',         // 요청 방식 (POST 또는 GET)
	        data: formData,       // 폼 데이터
	        processData: false,   // FormData 객체는 자동으로 처리되지 않도록 설정
	        contentType: false,   // 서버에서 처리할 수 있는 콘텐츠 타입으로 자동 설정
	        success: function(html) {
	            $('.main-content').html(html);  // 가져온 HTML을 main-content에 삽입
	        },
	        error: function(xhr, status, error) {
	            console.log("오류 발생:", status, error);
	            alert("폼 제출 중 오류가 발생했습니다.");
	        }
	    });
	}//writeReply
	
	
	function Update(detail, source) { // detail
	    		
  		const params = detail.split(',');
  		const no = params[0]; // msg_no는 첫 번째 값
		const pageNumber = params[1]; // pageNumber는 두 번째 값
		const whatColumn = params[2]; // whatColumn은 세 번째 값
		const keyword = params[3]; // keyword는 네 번째 값
		const kind = params[4];
		
		let url = '';
	    
	    if (source === 'notice') {  
	        url = 'notice_update.erp';
	    } else {
	        console.log("기본 메시지 상세 조회");
	    }
		$.ajax({
			url: url,  // 서버에서 메세지 상세 정보를 처리할 URL
			type: 'GET',
			data: { 
				no: no, 
				pageNumber: pageNumber, 
				whatColumn: whatColumn, 
				keyword: keyword, 
				kind: kind
			},  // 메세지 ID를 서버로 전달
			success: function(html) {
				$('.main-content').html(html);  // 가져온 HTML을 main-content에 삽입
			},
				error: function() {
					alert('메세지 로딩 중 오류가 발생했습니다.');
				}
		});
	} // Update
	
	
	
	
	function MessageReply(msg_no) {
		currentModal = "mail_reply";
		$.ajax({
			url: 'ymh_messageReply.erp',  // 서버에서 메세지 상세 정보를 처리할 URL
			type: 'GET',
			data: { msg_no: msg_no },  // 메세지 ID를 서버로 전달
			success: function(html) {
				$('#modalContent').html(html);
				$('#customModal').show();
			},
			error: function() {
				alert("모달 로딩 실패");
			}
	    });
	} // MessageReply
		
	
	
	
	function MessagePass(msg_no) {
		currentModal = "mail_pass";
		$.ajax({
			url: 'ymh_messagePass.erp',  // 서버에서 메세지 상세 정보를 처리할 URL
			type: 'GET',
			data: { msg_no: msg_no },  // 메세지 ID를 서버로 전달
			success: function(html) {
				$('#modalContent').html(html);
				$('#customModal').show();
			},
			error: function() {
				alert("모달 로딩 실패");
			}
		});
	} // MessagePass
	
		
	
	
	function Delete(detail, source) {
		
		const params = detail.split(',');
  		const no = params[0]; // msg_no는 첫 번째 값
		const pageNumber = params[1]; // pageNumber는 두 번째 값
		const whatColumn = params[2]; // whatColumn은 세 번째 값
		const keyword = params[3]; // keyword는 네 번째 값
		const kind = params[4].trim();
		const reply_no = params[5];
		
		let url = '';
	    
	    if (source === 'message') {  
	        url = 'ymh_messageDelete.erp';
	    } else if (source === 'reply') {
	        url = 'reply_delete.erp';
	    } else if (source === 'notice') {
	        url = 'notice_delete.erp';
	    } else {
	        console.log("기본 메시지 상세 조회");
	    }
	    
		$.ajax({
			url: url,  // 서버에서 메세지 상세 정보를 처리할 URL
			type: 'GET',
			data: { 
				no: no, 
				pageNumber: pageNumber, 
				whatColumn: whatColumn, 
				keyword: keyword, 
				kind: kind,
				reply_no: reply_no
			},
			success: function(html) {
				$('.main-content').html(html);
				alert("삭제 성공했습니다.");
			},
			error: function() {
				alert("삭제 중 오류가 발생했습니다.");
			}
		});
	} // MessageDelete

	
	
	
	//AuthInfo 권한 부여/해제 요청 함수
	function submitAuthority(actionType) {
		const form = document.querySelector("form[action='empAuthInfo.erp']");
		const formData = new FormData(form);

		const auth_cd = formData.get("auth_cd");
		const empNos = [];
		form.querySelectorAll("input[name='emp_no']:checked").forEach(input => {
			empNos.push(input.value);
		});

		if (empNos.length === 0) {
			alert("사원을 선택해주세요.");
			return;
		}

		$.ajax({
			url: 'empAuthInfo.erp', // 기존 컨트롤러 재활용
			method: 'POST',
			data: {
				auth_cd: auth_cd,
				actionType: actionType,
				emp_no: empNos
			},
			traditional: true, // emp_no[]=1&emp_no[]=2 형태로 전송됨
			success: function () {
				alert("처리되었습니다.");
				loadContent("authInfo"); // 본문 새로고침
			},
			error: function () {
				alert("처리 실패");
			}
		});
	}//권한부여,해제

	// 본문이 로딩될 때 버튼 이벤트 연결
	function bindAuthorityEvents() {
		$(document).off("click", "#grantBtn").on("click", "#grantBtn", function () {
			submitAuthority("grant");
		});
		$(document).off("click", "#revokeBtn").on("click", "#revokeBtn", function () {
			submitAuthority("revoke");
		});
	}

	//삭제 메서드
	function bindDeleteEvent() {
		
  $(document).off("click", ".deleteBtn").on("click", ".deleteBtn", function () {
    const url = $(this).data("url");
    const name = $(this).data("name") || "항목";
    let params = {};

    try {
      params = JSON.parse($(this).attr("data-params"));//JSON.parse 문자열을 객체로바꿔서 쓰고 싶을때 사용
    } catch (e) {
      alert("삭제 파라미터 오류");
      return;
    }

    if (!confirm(name + "을(를) 삭제하시겠습니까?")) return;
    
    $.ajax({
      url: url,
      type: "GET",
      data: params,
      success: function () {
        alert(name + " 삭제 완료");
        loadContent(currentPage);
      },
      error: function () {
        alert(name + " 삭제 실패");
      }
    });
  });
}
	function bindSignAppr() {
		
  $(document).off("click", ".signBtn").on("click", ".signBtn", function () {
    const url = $(this).data("url");
    const name = $(this).data("name") || "항목";
    let params = {};

    try {
      params = JSON.parse($(this).attr("data-params"));//JSON.parse 문자열을 객체로바꿔서 쓰고 싶을때 사용
    } catch (e) {
      alert("승인 파라미터 오류");
      return;
    }

    if (!confirm(name + "을(를) 승인하시겠습니까?")) return;
    
    $.ajax({
      url: url,
      type: "GET",
      data: params,
      success: function () {
        alert(name + " 승인 완료");
        loadContent(currentPage);
      },
      error: function () {
        alert(name + " 승인 실패");
      }
    });
  });
}

	window.userAuths = "${sessionScope.currentAuth}".split(",");

	
	function hideUnauthorizedButtons() {
		  const currentAuths = window.userAuths || []; // 현재 로그인 사용자의 권한 배열

		  $(".auth-btn").each(function () {
		    const required = $(this).data("auth"); // 버튼에 적힌 권한 문자열
		    if (!required) return; // 권한 체크 안 해도 되는 버튼이면 그냥 통과

		    const requiredAuths = required.split(","); // 예: "관리자권한,권한등록권한" → 배열

		    let hasPermission = false;

		    // 현재 로그인한 사용자의 권한 중 하나라도 일치하면 허용
		    for (let i = 0; i < requiredAuths.length; i++) {
		      for (let j = 0; j < currentAuths.length; j++) {
		        if (requiredAuths[i].trim() === currentAuths[j].trim()) {
		          hasPermission = true;
		          break; // 내부 루프 종료
		        }
		      }
		      if (hasPermission) break; // 외부 루프도 탈출
		    }

		    if (!hasPermission) {
		      $(this).hide(); // 권한이 없으면 버튼 숨기기
		    }
		  });
		}


	//휴가 승인 반려 메서드
	function vacationConfirm(vacation_no,source) {
  
  		  
		let url = '';
	    
	    if (source === 'appr') {  
	        url = 'vacationApproval.erp';
	    } else if (source === 'reject') {
	        url = 'vacationReject.erp';
	    } else {
	        console.log("기본 승인 반려");
	    }
    
    $.ajax({
      url: url,
      type: "GET",
      data: {vacation_no : vacation_no},
      success: function(html) {
			$('.main-content').html(html);
			if(source == 'appr'){
			alert("승인 성공했습니다.");
				
			}else{
			alert("반려 성공했습니다.");
				
			}
		},
		error: function() {
			alert("오류가 발생했습니다.");
		}
	});
 
}


</script>