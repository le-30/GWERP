<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="./../common/common.jsp" %>

<!-- 전체 메시지 뷰 래퍼 -->
<div style="width: 70%; margin: 0 auto;">

    <!-- 메일함 이동 링크 -->
    <div style="margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center;">
	    <div>
	        <c:choose>
	            <c:when test="${mb.send_emp_no != sessionScope.emp_no }">
	                <div class="sideTr" data-action="page" data-target="received" onclick="handleSidebar(this)"
	                     style="cursor: pointer; color: #007bff; font-weight: bold; display: inline-block;">
	                    <i class="fas fa-inbox sideIcon"></i> 받은 메일함
	                    <input type="hidden" value="${whatColumn}" name="whatColumn">
						<input type="hidden" value="${keyword}" name="keyword">
						<input type="hidden" value="${pageNumber}" name="pageNumber">
	                </div>
	            </c:when>
	            <c:otherwise>
	                <div class="sideTr" data-action="page" data-target="send" onclick="handleSidebar(this)"
	                     style="cursor: pointer; color: #007bff; font-weight: bold; display: inline-block;">
	                    <i class="fas fa-paper-plane sideIcon"></i> 보낸 메일함
	                    <input type="hidden" value="${whatColumn}" name="whatColumn">
						<input type="hidden" value="${keyword}" name="keyword">
						<input type="hidden" value="${pageNumber}" name="pageNumber">
	                </div>
	            </c:otherwise>
	        </c:choose>
	    </div>
	</div>


    <!-- 상단 버튼 영역 -->
    <div style="display: flex; gap: 10px; margin-bottom: 20px;">
        <c:if test="${mb.send_emp_no != sessionScope.emp_no }">
            <a href="javascript:void(0)" onclick="MessageReply('${mb.msg_no}')"
               style="display: inline-block; padding: 6px 14px; background-color: #28a745; color: white; text-decoration: none; border-radius: 5px;">
               답장
            </a>
            <a href="javascript:void(0)" onclick="MessagePass('${mb.msg_no}')"
               style="display: inline-block; padding: 6px 14px; background-color: #17a2b8; color: white; text-decoration: none; border-radius: 5px;">
               전달
            </a>
        </c:if>
        <a href="javascript:void(0)" onclick="Delete('${mb.msg_no},${pageNumber},${whatColumn},${keyword},message,null', 'message')"
           style="display: inline-block; padding: 6px 14px; background-color: #dc3545; color: white; text-decoration: none; border-radius: 5px;">
           삭제
        </a>
    </div>

    <!-- 제목 / 발신 / 수신 / 날짜 -->
    <div style="display: flex; flex-direction: column; padding: 10px; border-bottom: 1px solid #ddd; gap: 10px;">
        <div style="font-weight: bold; font-size: 20px;">${mb.msg_title}</div>
        <div>보낸사람 : ${mb.send_emp_name}</div>
        <div>받는사람 : ${mb.receive_emp_name}</div>
        <div style="font-size: 14px; color: #808080;">
            <fmt:formatDate value="${mb.send_dtm}" pattern="yyyy년 M월 d일 (E) a h:mm"/>
        </div>
    </div>

    <!-- 본문 내용 -->
    <div style="padding: 30px 20px; border-bottom: 1px solid #ddd;">
        ${mb.msg_content}
    </div>

    <!-- 첨부파일 -->
    <div style="text-align: right; margin-top: 10px;">
        <a href="download.erp?msg_no=${mb.msg_no}">
            ${ab.org_file_name}
        </a>
    </div>
</div>
