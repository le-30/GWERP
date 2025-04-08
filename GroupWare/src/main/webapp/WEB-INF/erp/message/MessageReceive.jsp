<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="./../common/common.jsp" %>

<!-- 상단 검색 영역 -->
<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
	<h4 style="margin-bottom: 20px; font-size: 18px; color: #2c3e50; font-weight: bold;">
		📥 받은 메신저 <span style="color: #3498db;">(${readCount}/${totalCount})</span>
	</h4>
	<form id="receiveSearchForm" style="display: flex; gap: 10px; align-items: center;">
		<select name="whatColumn" style="padding: 5px;">
			<option value="">전체 선택</option>
			<option value="send_emp_name">보낸 사람</option>
			<option value="msg_title">제목</option>
		</select>
		<input type="text" name="keyword" id="receiveKeywordInput" placeholder="검색어 입력" style="padding: 5px;">
		<input type="button" value="검색" id="receiveSearchBtn" style="padding: 6px 12px;">
	</form>
</div>

<!-- 리스트 전체 감싸는 영역 -->
<div id="msgReceiveListContainer" style="background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">

	<!-- 헤더 -->
	<div style="display: grid; grid-template-columns: 1fr 1.5fr 3fr 1.5fr; background: #f9f9f9; padding: 10px; font-weight: bold; border-bottom: 2px solid #ddd;">
		<div style="min-width: 65px; text-align: left; padding-left: 20px;">읽음 상태</div>
		<div>보낸 사람</div>
		<div>제목</div>
		<div>시간</div>
	</div>

	<!-- 리스트 -->
	<c:if test="${totalCount == 0}">
		<div style="padding: 20px; text-align: center; border-bottom: 1px solid #eee;">받은 메일이 없습니다.</div>
	</c:if>

	<c:forEach var="mb" items="${receivelist}">
		<div style="display: grid; grid-template-columns: 1fr 1.5fr 3fr 1.5fr; padding: 12px 10px; border-bottom: 1px solid #eee; align-items: center;">
			<!-- 읽음 상태 -->
			<div style="min-width: 65px; display: flex; justify-content: flex-start; align-items: center; padding-left: 50px;">
			    <span style="font-size: 18px; color: ${mb.read_yn == 'Y' ? '#2ecc71' : '#bdc3c7'};">
			        ${mb.read_yn == 'Y' ? '✔' : '✖'}
			    </span>
			</div>

	
			<!-- 보낸 사람 -->
			<div>
				<div style="font-weight: bold;">${mb.send_emp_name}</div>
				<div style="font-size: 12px; color: #888;">${mb.send_dept_nm} · ${mb.send_position_nm}</div>
			</div>
	
			<!-- 제목 -->
			<div style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
				<a href="javascript:void(0)"
				   onclick="Detail('${mb.msg_no},${pageInfo.pageNumber },${pageInfo.whatColumn },${pageInfo.keyword }', 'message')"
				   style="
				   	text-decoration: none;
				   	color: ${mb.read_yn == 'Y' ? '#999' : '#333'};
				   	font-weight: ${mb.read_yn == 'Y' ? 'normal' : 'bold'};
				   ">
					${mb.msg_title}
				</a>
			</div>
	
			<!-- 시간 -->
			<div>
				<fmt:formatDate value="${mb.send_dtm}" pattern="MM.dd HH:mm"/>
			</div>
		</div>
	</c:forEach>

	<!-- 페이징 -->
	<div id="paging" style="margin-top: 20px; text-align: center;">
		${pageInfo.pagingHtml}
	</div>
</div>
