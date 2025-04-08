<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- /WEB-INF/views/main.jsp -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="./../common/common.jsp" %>

<style>

html {
	overflow-y: scroll;
}

</style>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>main</title>
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>

    <style>
        .main-content {
            margin-left: 250px;
            margin-top: 7vh;
            padding: 20px;
            box-sizing: border-box;
        }
    </style>
</head>
<body>

    <!-- header include -->
    <jsp:include page="header.jsp" />

    <!-- sidebar include -->
    <jsp:include page="sidebar.jsp" />

    <!-- 본문 -->
    <div class="main-content">
    	
    </div>
    
    <!-- 모달 영역 -->
	<!-- 공통 모달 레이아웃 -->
<div id="customModal" class="modal-wrapper" style="display: none;">
  <div class="modal-box">
    <div id="modalContent"></div>
    <div class="modal-footer">
    </div>
  </div>
</div>

    
    
    <%@include file ="./../js/headerTap.jsp" %>
    <%@include file ="./../js/mainContent.jsp" %>
    <%@include file ="./../js/modalControl.jsp" %>
    <%@include file ="./../js/detailHandler.jsp" %>
    
   
	
</body>
</html>
    