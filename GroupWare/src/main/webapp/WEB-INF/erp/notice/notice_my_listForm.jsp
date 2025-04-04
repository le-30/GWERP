<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file=".././common/common.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/styles/notice_list_style.css">
<div id="mnoticeListContainer">
<br>
	등록된 공지 : ${totalCount}
<br>
<c:if test="${totalCount == 0 }">
	<table width="700">
		<tr>
			<td align="center">
				공지사항이 없습니다.
			</td>
		</tr>
	</table>
</c:if>
<c:if test="${totalCount != 0 }">
	<table border="1" width="700" align="center">
		<tr>
			<th width="450" align="center">제 목</th>
			<th width="100" align="left">작성자</th>
			<th width="100" align="center">작성일</th>
			<th width="50" align="center">조회</th>
		</tr>
	</table>
	<br><br>
	<table border="1" width="700" align="center">
		<c:forEach var="nl" items="${noticeLists2 }">
			<tr>
				<td align="center" width="100">
					작성중
				</td>
				<td align="left" width="350">
					<a href="javascript:void(0)" onclick="Detail('${nl.notice_no},${pageInfo.pageNumber },${pageInfo.whatColumn },${pageInfo.keyword }, my', 'notice')">${nl.notice_title }</a>
				</td>
				<td align="left" width="100">
					${nl.emp_nm }
				</td>
				<td align="center" width="100">
					<fmt:formatDate value="${nl.notice_dtm}" pattern="${nl.isWithin24Hours() ? 'HH:mm' : 'yyyy-MM-dd'}" />
				</td>
				<td align="center" width="50">
					${nl.notice_views }
				</td>
			</tr>
		</c:forEach>
	</table>
	<br><br>
	<table border="1" width="700" align="center">
		<c:forEach var="nl" items="${noticeLists0 }">
			<tr>
				<c:if test="${nl.emp_no == sessionScope.emp_no }">
					<td align="center" width="100">
						${nl.dept_nm }
					</td>
					<td align="left" width="350">
						<a href="javascript:void(0)" onclick="Detail('${nl.notice_no},${pageInfo.pageNumber },${pageInfo.whatColumn },${pageInfo.keyword }, my', 'notice')">${nl.notice_title }</a>
					</td>
					<td align="left" width="100">
						${nl.emp_nm }
					</td>
					<td align="center" width="100">
						<fmt:formatDate value="${nl.notice_dtm}" pattern="${nl.isWithin24Hours() ? 'HH:mm' : 'yyyy-MM-dd'}" />
					</td>
					<td align="center" width="50">
						${nl.notice_views }
					</td>
				</c:if>
			</tr>
		</c:forEach>
	</table>
<br><br>
<center>
<form action="notice_list.erp" method="get">  
	<select name="whatColumn">
		<option value="">전체 검색</option>
		<option value="emp_nm">작성자</option>
		<option value="notice_title">제목</option>
	</select>
	<input type="text" name="keyword">
	<input type="submit" value="검색">
</form>
</center>
</c:if>
<div id="paging" align="center">
	${pageInfo.pagingHtml}
</div>
</div>