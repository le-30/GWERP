<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="./../common/common.jsp" %>


<form id="authSearchForm">
  <select name="whatColumn">
    <option value="">전체 선택</option>
    <option value="auth_cd">권한코드</option>
    <option value="auth_nm">권한이름</option>
  </select>
  <input type="text" name="keyword" id="authKeywordInput">
  <input type="button" value="검색" id="authSearchBtn">  
</form>
<br><br>

<div id="authListContainer">
	<table border="1">
		<tr>
			<th>권한코드</th>
			<th>권한 이름</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>	
		
		<c:forEach var="auth" items="${authList}">
		<tr>
			<th>${auth.auth_cd }</th>
			<th>${auth.auth_nm }</th>
			
			<th> <button class="open-edit-modal"
					  data-url="cmmCode_update.erp"
					  data-id="${auth.auth_cd }">
					  수정
			  </button>
			</th>
			<th>
			<button class="deleteBtn" 
        			data-url="auth_delete.erp"
        			data-name="권한관리"
       			    data-params='{"auth_cd":"${auth.auth_cd }"}'>
       				 삭제
			</button>
			</th>
			
		</tr>	
		</c:forEach>
	</table>
<div id="paging">
${pageInfo.pagingHtml}
</div>
</div>