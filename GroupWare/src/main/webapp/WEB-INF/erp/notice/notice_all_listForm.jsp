<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file=".././common/common.jsp" %>

<div id="anoticeListContainer" style="background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
	<h4 style="margin-bottom: 20px;">📝 등록된 공지 (${totalCount})</h4>

	<c:if test="${totalCount == 0 }">
		<div style="text-align: center; padding: 20px; border: 1px solid #eee;">공지사항이 없습니다.</div>
	</c:if>

	<c:if test="${totalCount != 0 }">
	
		<!-- 필독 공지 헤더 -->
		<div style="display: grid; grid-template-columns: 1fr 3fr 1.5fr 1.5fr 1fr; font-weight: bold; background: #fff3f3; padding: 10px; border-bottom: 2px solid #f1948a;">
		    <div style="text-align: left;">구분</div>
		    <div style="text-align: left;">제목</div>
		    <div style="text-align: left;">작성자</div>
		    <div style="text-align: left;">작성일</div>
		    <div style="text-align: center;">조회</div>
		</div>
		
		<!-- 필독 공지 내용 -->
		<c:forEach var="nl" items="${noticeLists1 }">
		    <div style="display: grid; grid-template-columns: 1fr 3fr 1.5fr 1.5fr 1fr; padding: 12px 10px; border-bottom: 1px solid #eee; align-items: center; background: #fffafa;">
		        <div style="text-align: left; color: #e74c3c; font-weight: bold;">필독</div>
		        <div style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
		            <a href="javascript:void(0)"
		               onclick="Detail('${nl.notice_no},${pageInfo.pageNumber },${pageInfo.whatColumn },${pageInfo.keyword }, total', 'notice')"
		               style="text-decoration: none; color: #2c3e50; font-weight: bold;">
		                ${nl.notice_title}
		            </a>
		        </div>
		        <div style="text-align: left;">${nl.emp_nm}</div>
		        <div style="text-align: left;">
		            <fmt:formatDate value="${nl.notice_dtm}" pattern="${nl.isWithin24Hours() ? 'HH:mm' : 'yyyy-MM-dd'}" />
		        </div>
		        <div style="text-align: center;">${nl.notice_views}</div>
		    </div>
		</c:forEach>

	
		<!-- 일반 공지 헤더 -->
		<h5 style="margin: 40px 0 10px; font-weight: bold; color: #2c3e50;">📄 일반 공지</h5>
		<div style="display: grid; grid-template-columns: 1fr 3fr 1.5fr 1.5fr 1fr; font-weight: bold; background: #f9f9f9; padding: 10px; border-bottom: 2px solid #ddd;">
		    <div style="text-align: left;">구분</div>
		    <div style="text-align: left;">제목</div>
		    <div style="text-align: left;">작성자</div>
		    <div style="text-align: left;">작성일</div>
		    <div style="text-align: center;">조회</div>
		</div>
		
		<!-- 일반 공지 내용 -->
		<c:forEach var="nl" items="${noticeLists0 }">
		    <div style="display: grid; grid-template-columns: 1fr 3fr 1.5fr 1.5fr 1fr; padding: 12px 10px; border-bottom: 1px solid #eee; align-items: center;">
		        <div style="text-align: left; color: #3498db;">${nl.dept_nm}</div>
		        <div style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; text-align: left;">
		            <a href="javascript:void(0)"
		               onclick="Detail('${nl.notice_no},${pageInfo.pageNumber },${pageInfo.whatColumn },${pageInfo.keyword }, total', 'notice')"
		               style="text-decoration: none; color: #333;">
		                ${nl.notice_title}
		            </a>
		        </div>
		        <div style="text-align: left;">${nl.emp_nm}</div>
		        <div style="text-align: left;">
		            <fmt:formatDate value="${nl.notice_dtm}" pattern="${nl.isWithin24Hours() ? 'HH:mm' : 'yyyy-MM-dd'}" />
		        </div>
		        <div style="text-align: center;">${nl.notice_views}</div>
		    </div>
		</c:forEach>
	
	</c:if>

	<!-- 페이징 -->
	<div id="paging" style="margin-top: 20px; text-align: center;">
		${pageInfo.pagingHtml}
	</div>
</div>
