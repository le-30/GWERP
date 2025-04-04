<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file=".././common/common.jsp" %>

<table border="1" width="500">
	<tr height="30">
		<td colspan="4" align="right">
			<div class="sideTr" data-action="page"
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
	             onclick="handleSidebar(this)">
	            <input type="hidden" value="${whatColumn}" name="whatColumn">
	            <input type="hidden" value="${keyword}" name="keyword">
	            <input type="hidden" value="${pageNumber}" name="pageNumber">
	            <i class="fas fa-flag sideIcon"></i> 글목록
	        </div>
		</td>
	</tr>
	<tr height="30">
		<td width="375" colspan="4">${notice.notice_title }</td>
	</tr>
	<tr height="30">
		<td width="125" colspan="4">${notice.emp_nm }</td>
	</tr>
	<tr height="30">
		<td width="125">
			<fmt:formatDate value="${notice.notice_dtm }" type="date" pattern="yyyy-MM-dd HH:mm" />
		</td>
		<td width="125">${notice.notice_views }</td>
	</tr>
	<c:if test="${fileName != null}">
		<tr>
			<td>첨부파일</td>
			<td><a href="download.erp?notice_no=${notice.notice_no}">${fileName }</a></td>
		</tr>
	</c:if>
	<tr height="180">
		<td width="375" colspan="4">${notice.notice_content }</td>
	</tr>
	<c:if test="${notice.emp_no == sessionScope.emp_no}">
		<tr height="30">
			<td colspan="4" align="right">
			<a href="javascript:void(0)" onclick="Update('${notice.notice_no},${pageNumber },${whatColumn },${keyword }, ${fn:trim(kind) }', 'notice')">글수정</a>
			<a href="javascript:void(0)" onclick="Delete('${notice.notice_no},${pageNumber },${whatColumn },${keyword }, ${fn:trim(kind) }', 'notice')">글삭제</a>
			</td>
		</tr>
	</c:if>
</table>
<br><br>
<form:form commandName="reply" method="post" action="reply_write.erp" id="norice_write_reply">
	<input type="hidden" name="emp_no" value="${sessionScope.emp_no }">
	<input type="hidden" name="emp_nm" value="${sessionScope.emp_nm }">
	<input type="hidden" name="notice_no" value="${notice.notice_no }">
	<input type="hidden" name="pageNumber" value="${pageNumber }">
	<input type="hidden" name="whatColumn" value="${whatColumn }">
	<input type="hidden" name="keyword" value="${keyword }">
	<input type="hidden" name="kind" value="${kind }">
	
	<table border="1" width="500">
		<tr height="100">
			<td>
				<textarea name="reply_content" rows="6" cols="60">${reply.reply_content }</textarea>
				<form:errors cssClass="err" path="reply_content"/>
			</td>
			<td>
				<input type="button" value="작성" onClick="writeReply()">
			</td>
		</tr>
	</table>  
</form:form>
<table border="1" width="500">
	<c:forEach var="rl" items="${replyLists }">
			<c:if test="${rl.notice_no == notice.notice_no}">
				<tr>
					<td>
						${rl.emp_nm }
					</td>
				</tr>
				<tr>
					<td>
						${rl.reply_content }
					</td>
				</tr>
				<tr>
					<td>
						<fmt:formatDate value="${rl.reply_dtm }" type="date" pattern="yyyy-MM-dd HH:mm"/>
						<c:if test="${rl.emp_no == sessionScope.emp_no}">
							<a href="javascript:void(0)" onclick="Delete('${notice.notice_no},${pageNumber },${whatColumn },${keyword }, ${fn:trim(kind) }, ${rl.reply_no }', 'reply')">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:if>
		</c:forEach>
</table>
