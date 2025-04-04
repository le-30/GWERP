<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>연차 정보</title>
    <style>
        table {
            width: 70%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        p {
            text-align: center;
            font-size: 18px;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <h2 style="text-align: center;">내 연차 정보</h2>

    <c:choose>
        <c:when test="${not empty employee and not empty leaveInfo}">
            <table>
                <tr>
                    <th>사원번호</th>
                    <th>사원명</th>
                    <th>잔여 연차</th>
                </tr>
                <tr>
                    <td>${employee.emp_no}</td>
                    <td>${employee.emp_nm}</td>
                    <td style="color: blue;">${leaveInfo.annual_leave} 일</td>
                </tr>
            </table>
        </c:when>
        <c:otherwise>
            <p style="color: red;">연차 정보가 없습니다.</p>
        </c:otherwise>
    </c:choose>

    <h2 style="text-align: center; margin-top: 30px;">전체 사원 연차 정보</h2>

    <c:choose>
        <c:when test="${not empty employeeList}">
            <table>
                <tr>
                    <th>사원번호</th>
                    <th>사원명</th>
                    <th>잔여 연차</th>
                </tr>
                <c:forEach var="emp" items="${employeeList}">
                    <tr>
                        <td>${emp.emp_no}</td>
                        <td>${emp.emp_nm}</td>
                        <td style="color: blue;">${emp.annual_leave} 일</td>
                    </tr>
                </c:forEach>
            </table>
        </c:when>
        <c:otherwise>
            <p style="color: red;">전체 사원 연차 정보가 없습니다.</p>
        </c:otherwise>
    </c:choose>

</body>
</html>
<br><br>
<div id="paging">
${pageInfo.pagingHtml}
</div>