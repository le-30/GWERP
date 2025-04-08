<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file=".././common/common.jsp" %>

<div id="mnoticeListContainer" style="background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
	<h4 style="margin-bottom: 20px;">📝 내가 쓴 공지 (${totalCount})</h4>

	<c:if test="${totalCount == 0}">
		<div style="text-align: center; padding: 20px; border: 1px solid #eee;">공지사항이 없습니다.</div>
	</c:if>

	<c:if test="${totalCount != 0}">
		<!-- 작성 중인 공지 구간 -->
		<c:set var="hasDraft" value="false" />
		<c:forEach var="nl" items="${noticeLists2}">
			<c:if test="${nl.emp_no == sessionScope.emp_no}">
				<c:set var="hasDraft" value="true" />
			</c:if>
		</c:forEach>

		<c:if test="${hasDraft}">
			<h5 style="margin: 30px 0 10px; font-weight: bold; color: #e67e22;">📌 작성 중인 공지</h5>
			<!-- 헤더 -->
			<div style="display: grid; grid-template-columns: 1fr 3fr 1.5fr 1.5fr 1fr; font-weight: bold; background: #f9f9f9; padding: 10px; border-bottom: 2px solid #ddd;">
				<div style="text-align: left;">구분</div>
				<div style="text-align: left;">제목</div>
				<div style="text-align: left;">작성자</div>
				<div style="text-align: left;">작성일</div>
				<div style="text-align: center;">조회</div>
			</div>

			<c:forEach var="nl" items="${noticeLists2}">
				<c:if test="${nl.emp_no == sessionScope.emp_no}">
					<div style="display: grid; grid-template-columns: 1fr 3fr 1.5fr 1.5fr 1fr; padding: 12px 10px; border-bottom: 1px solid #eee; align-items: center;">
						<div style="text-align: left; color: #e67e22;">작성중</div>
						<div style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; text-align: left;">
							<a href="javascript:void(0)"
							   onclick="Detail('${nl.notice_no},${pageInfo.pageNumber },${pageInfo.whatColumn },${pageInfo.keyword }, my', 'notice')"
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
				</c:if>
			</c:forEach>
		</c:if>

		<!-- 등록 완료된 공지 구간 -->
		<c:set var="hasPosted" value="false" />
		<c:forEach var="nl" items="${noticeLists0}">
			<c:if test="${nl.emp_no == sessionScope.emp_no}">
				<c:set var="hasPosted" value="true" />
			</c:if>
		</c:forEach>

		<c:if test="${hasPosted}">
			<h5 style="margin: 40px 0 10px; font-weight: bold; color: #3498db;">✅ 등록된 공지</h5>
			<!-- 헤더 -->
			<div style="display: grid; grid-template-columns: 1fr 3fr 1.5fr 1.5fr 1fr; font-weight: bold; background: #f9f9f9; padding: 10px; border-bottom: 2px solid #ddd;">
				<div style="text-align: left;">구분</div>
				<div style="text-align: left;">제목</div>
				<div style="text-align: left;">작성자</div>
				<div style="text-align: left;">작성일</div>
				<div style="text-align: center;">조회</div>
			</div>

			<c:forEach var="nl" items="${noticeLists0}">
				<c:if test="${nl.emp_no == sessionScope.emp_no}">
					<div style="display: grid; grid-template-columns: 1fr 3fr 1.5fr 1.5fr 1fr; padding: 12px 10px; border-bottom: 1px solid #eee; align-items: center;">
						<div style="text-align: left; color: #3498db;">${nl.dept_nm}</div>
						<div style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; text-align: left;">
							<a href="javascript:void(0)"
							   onclick="Detail('${nl.notice_no},${pageInfo.pageNumber },${pageInfo.whatColumn },${pageInfo.keyword }, my', 'notice')"
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
				</c:if>
			</c:forEach>
		</c:if>

		<!-- 검색 -->
		<div style="margin-top: 30px; text-align: center;">
			<form action="notice_list.erp" method="get" style="display: flex; justify-content: center; gap: 10px; align-items: center;">
				<select name="whatColumn" style="padding: 6px;">
					<option value="">전체 검색</option>
					<option value="emp_nm">작성자</option>
					<option value="notice_title">제목</option>
				</select>
				<input type="text" name="keyword" style="padding: 6px;">
				<input type="submit" value="검색" style="padding: 6px 12px;">
			</form>
		</div>
	</c:if>

	<!-- 페이징 -->
	<div id="paging" style="margin-top: 20px; text-align: center;">
		${pageInfo.pagingHtml}
	</div>
</div>
