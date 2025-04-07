<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>연차 정보</title>
    <style>
        body {
            background-color: #f5f5f5;
            font-family: 'Segoe UI', sans-serif;
        }

        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        }

        h2 {
            font-size: 24px;
            font-weight: bold;
            border-left: 6px solid #007bff;
            padding-left: 12px;
            margin: 30px 0 20px;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }

        th {
            background-color: #007bff;
            color: white;
            text-transform: uppercase;
            font-size: 14px;
        }

        td {
            font-size: 15px;
        }

        td:last-child {
            color: #007bff;
            font-weight: bold;
        }

        .no-data {
            text-align: center;
            color: red;
            font-weight: bold;
            padding: 30px 0;
        }

        #paging {
            text-align: center;
            margin-top: 30px;
        }
    </style>
</head>
<body>

<div class="container">

    <h2>👤 내 연차 정보</h2>
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
                    <td>${leaveInfo.annual_leave} 일</td>
                </tr>
            </table>
        </c:when>
        <c:otherwise>
            <div class="no-data">연차 정보가 없습니다.</div>
        </c:otherwise>
    </c:choose>

    <h2>🏢 전체 사원 연차 정보</h2>
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
                        <td>${emp.annual_leave} 일</td>
                    </tr>
                </c:forEach>
            </table>
        </c:when>
        <c:otherwise>
            <div class="no-data">전체 사원 연차 정보가 없습니다.</div>
        </c:otherwise>
    </c:choose>

    <div id="paging">
        ${pageInfo.pagingHtml}
    </div>
</div>

</body>
</html>
