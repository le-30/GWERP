<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file=".././common/common.jsp" %>

<!-- 공지 상세 전체 래퍼 -->
<div style="width: 70%; margin: 0 auto; display: flex; flex-direction: column; gap: 20px;">

    <!-- 글 목록 버튼 -->
    <div style="display: flex; justify-content: flex-start;">
	    <div style="max-width: 150px;">
	        <div class="sideTr"
	             data-action="page"
	             <c:choose>
	                 <c:when test="${fn:trim(kind) == 'total'}">
	                     data-target="totalNotice"
	                 </c:when>
	                 <c:when test="${fn:trim(kind) == 'dept'}">
	                     data-target="deptNotice"
	                 </c:when>
	                 <c:otherwise>
	                     data-target="myNotice"
	                 </c:otherwise>
	             </c:choose>
	             onclick="handleSidebar(this)"
	             style="cursor: pointer; color: #007bff; font-weight: bold; display: inline-block; padding: 6px 12px;">
	            <input type="hidden" value="${whatColumn}" name="whatColumn">
				<input type="hidden" value="${keyword}" name="keyword">
				<input type="hidden" value="${pageNumber}" name="pageNumber">
	            <i class="fas fa-flag sideIcon"></i> 글목록
	        </div>
	    </div>
	</div>

    <!-- 공지 제목 및 정보 -->
    <div style="display: flex; flex-direction: column; gap: 10px; padding: 20px; border: 1px solid #ddd; border-radius: 8px;">
        <div style="font-size: 20px; font-weight: bold;">${notice.notice_title}</div>
        <div>작성자: ${notice.emp_nm}</div>
        <div style="font-size: 14px; color: gray;">
            <fmt:formatDate value="${notice.notice_dtm}" type="date" pattern="yyyy-MM-dd HH:mm" />
            | 조회수: ${notice.notice_views}
        </div>
        <c:if test="${fileName != null}">
            <div>첨부파일: <a href="download.erp?notice_no=${notice.notice_no}">${fileName}</a></div>
        </c:if>
    </div>

    <!-- 공지 본문 -->
    <div style="padding: 20px; border: 1px solid #ddd; border-radius: 8px;">
        ${notice.notice_content}
    </div>

    <!-- 수정/삭제 버튼 -->
    <c:if test="${notice.emp_no == sessionScope.emp_no}">
        <div style="display: flex; justify-content: flex-end; gap: 10px;">
            <a href="javascript:void(0)" onclick="Update('${notice.notice_no},${pageNumber},${whatColumn},${keyword},${fn:trim(kind)}', 'notice')"
               style="padding: 6px 14px; background-color: #17a2b8; color: white; text-decoration: none; border-radius: 5px;">글수정</a>
            <a href="javascript:void(0)" onclick="Delete('${notice.notice_no},${pageNumber},${whatColumn},${keyword},${fn:trim(kind)}', 'notice')"
               style="padding: 6px 14px; background-color: #dc3545; color: white; text-decoration: none; border-radius: 5px;">글삭제</a>
        </div>
    </c:if>

    <!-- 댓글 작성 -->
    <form:form commandName="reply" method="post" action="reply_write.erp" id="norice_write_reply">
        <input type="hidden" name="emp_no" value="${sessionScope.emp_no}">
        <input type="hidden" name="emp_nm" value="${sessionScope.emp_nm}">
        <input type="hidden" name="notice_no" value="${notice.notice_no}">
        <input type="hidden" name="pageNumber" value="${pageNumber}">
        <input type="hidden" name="whatColumn" value="${whatColumn}">
        <input type="hidden" name="keyword" value="${keyword}">
        <input type="hidden" name="kind" value="${kind}">

        <div style="display: flex; gap: 10px; margin-top: 20px;">
            <textarea name="reply_content" rows="4" cols="60" style="flex-grow: 1;">${reply.reply_content}</textarea>
            <input type="button" value="작성" onClick="writeReply()">
        </div>
        <form:errors cssClass="err" path="reply_content"/>
    </form:form>

    <!-- 댓글 목록 -->
    <div style="display: flex; flex-direction: column; gap: 10px;">
        <c:forEach var="rl" items="${replyLists}">
            <c:if test="${rl.notice_no == notice.notice_no}">
                <div style="border: 1px solid #ddd; border-radius: 6px; padding: 10px;">
                    <div style="font-weight: bold;">${rl.emp_nm}</div>
                    <div>${rl.reply_content}</div>
                    <div style="font-size: 12px; color: gray; display: flex; justify-content: space-between;">
                        <fmt:formatDate value="${rl.reply_dtm}" type="date" pattern="yyyy-MM-dd HH:mm" />
                        <c:if test="${rl.emp_no == sessionScope.emp_no}">
                            <a href="javascript:void(0)" onclick="Delete('${notice.notice_no},${pageNumber},${whatColumn},${keyword},${fn:trim(kind)},${rl.reply_no}', 'reply')"
                               style="color: #dc3545; text-decoration: none;">삭제</a>
                        </c:if>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>