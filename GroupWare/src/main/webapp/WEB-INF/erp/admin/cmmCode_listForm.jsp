<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="./../common/common.jsp" %>

<form id="cmmCodeSearchForm">
  <select name="whatColumn">
    <option value="">전체 선택</option>
    <option value="cmm_class">공통코드 class</option>
    <option value="cmm_nm">공통코드 이름</option>
  </select>
  <input type="text" name="keyword" id="cmmCodekeywordInput">
  <input type="button" value="검색" id="cmmCodesearchBtn">  
</form>



<div id="cmmCodeListContainer">
	<table border="1">
		<tr>
			<th>공통코드 class</th>
			<th>공통코드 코드</th>
			<th>공통코드 이름</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>	
		
		<c:forEach var="cmmCode" items="${lists}">
		<tr>
			<th>${cmmCode.cmm_class }</th>
			<th>${cmmCode.cmm_cd }</th>
			<th>${cmmCode.cmm_nm }</th>
			<th> <button class="open-edit-modal"
					  data-url="cmmCode_update.erp"  
					  data-id="${cmmCode.cmm_nm }">
					  수정
			  </button>
			</th>
			<th>
			<button class="deleteBtn" 
        			data-url="cmmCode_delete.erp"
        			data-name="공통코드"
       			    data-params='{"cmm_cd":"${cmmCode.cmm_cd}","cmm_class":"${cmmCode.cmm_class}"}'>
       				 삭제
			</button>
			</th>
			
		</tr>	
		</c:forEach>
	</table>
	<br><br>
	
<div id="paging">
${pageInfo.pagingHtml}
</div>
</div>
