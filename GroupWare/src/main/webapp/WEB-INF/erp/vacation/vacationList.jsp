<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
    body {
        background-color: #f5f5f5;
        font-family: 'Segoe UI', sans-serif;
    }

    .container {
        max-width: 1100px;
        margin: 40px auto;
        padding: 20px;
        background: white;
        border-radius: 12px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
    }

    h2 {
        font-weight: bold;
        font-size: 24px;
        color: #333;
        border-left: 6px solid #007bff;
        padding-left: 15px;
        margin-bottom: 30px;
    }

    .search-area {
        display: flex;
        gap: 10px;
        margin-bottom: 20px;
    }

    .search-area input,
    .search-area select {
        padding: 8px 12px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 14px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        border-radius: 8px;
        overflow: hidden;
    }

    thead {
        background: #007bff;
        color: white;
        text-transform: uppercase;
    }

    th, td {
        padding: 12px;
        text-align: center;
        border: 1px solid #e0e0e0;
    }

    tbody tr:nth-child(odd) {
        background-color: #f9f9f9;
    }

    tbody tr:hover {
        background-color: #e3f2fd;
    }

    .badge {
        display: inline-block;
        padding: 6px 12px;
        font-size: 13px;
        border-radius: 12px;
        font-weight: bold;
    }

    .bg-success { background-color: #28a745; color: white; }
    .bg-danger { background-color: #dc3545; color: white; }
    .bg-secondary { background-color: #6c757d; color: white; }

    .btn {
        padding: 6px 10px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-size: 14px;
        font-weight: bold;
        transition: background-color 0.2s ease-in-out;
    }

    .btn-approve {
        background-color: #28a745;
        color: white;
    }

    .btn-approve:hover {
        background-color: #218838;
    }

    .btn-reject {
        background-color: #dc3545;
        color: white;
    }

    .btn-reject:hover {
        background-color: #c82333;
    }

    .paging {
        text-align: center;
        margin-top: 20px;
    }

    /* 모달 */
    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 0; top: 0;
        width: 100%; height: 100%;
        background-color: rgba(0,0,0,0.4);
    }

    .modal-content {
        background-color: #fff;
        margin: 15% auto;
        padding: 20px;
        border-radius: 10px;
        width: 400px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.3);
    }

    .modal-header {
        font-weight: bold;
        margin-bottom: 10px;
    }

    .modal-footer {
        text-align: right;
        margin-top: 20px;
    }

    .modal-footer .btn {
        margin-left: 10px;
    }
</style>

<div class="container">
    <h2>📝 휴가 신청 목록</h2>

    <div class="search-area">
        <input type="text" id="searchInput" placeholder="신청자 검색...">
        <select id="statusFilter">
            <option value="">상태 선택</option>
            <option value="✔ 승인">승인</option>
            <option value="❌ 반려">반려</option>
            <option value="⌛ 대기">대기</option>
        </select>
    </div>

    <table>
        <thead>
            <tr>
                <th>휴가 번호</th>
                <th>휴가 유형</th>
                <th>신청자</th>
                <th>휴가 기간</th>
                <th>총 휴가일수</th>
                <th>상태</th>
                <th>승인자</th>
                <th>승인</th>
                <th>반려</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${empty vacationList}">
                <tr>
                    <td colspan="9" style="color: #888;">현재 신청된 휴가가 없습니다.</td>
                </tr>
            </c:if>

            <c:if test="${not empty vacationList}">
                <c:forEach var="vacation" items="${vacationList}">
                    <tr>
                        <td>${vacation.vacation_no}</td>
                        <td>${vacation.vacation_type}</td>
                        <td>${vacation.req_emp_no}</td>
                        <td>
                            <span style="color: #007bff;">
                                <fmt:formatDate value="${vacation.start_dt}" pattern="yyyy-MM-dd"/>
                            </span> ~ 
                            <span style="color: #dc3545;">
                                <fmt:formatDate value="${vacation.end_dt}" pattern="yyyy-MM-dd"/>
                            </span>
                        </td>
                        <td>${vacation.total_days}</td>
                        <td>
                            <span class="badge 
                                <c:choose>
                                    <c:when test="${vacation.vacation_status == '승인'}">bg-success</c:when>
                                    <c:when test="${vacation.vacation_status == '반려'}">bg-danger</c:when>
                                    <c:otherwise>bg-secondary</c:otherwise>
                                </c:choose>
                            ">
                                <c:choose>
                                    <c:when test="${vacation.vacation_status == '승인'}">✔ 승인</c:when>
                                    <c:when test="${vacation.vacation_status == '반려'}">❌ 반려</c:when>
                                    <c:otherwise>⌛ 대기</c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td>${vacation.appr_emp_no}</td>
                        <td><button class="btn btn-approve" onclick="confirmApproval(${vacation.vacation_no})">✔ 승인</button></td>
                        <td><button class="btn btn-reject" onclick="confirmRejection(${vacation.vacation_no})">❌ 반려</button></td>
                    </tr>
                </c:forEach>
            </c:if>
        </tbody>
    </table>

    <div class="paging">
        ${pageInfo.pagingHtml}
    </div>
</div>

<!-- 모달 -->
<div id="confirmModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">확인</div>
        <div class="modal-body">
            <p id="modalMessage"></p>
        </div>
        <div class="modal-footer">
            <button class="btn btn-reject" onclick="closeModal()">취소</button>
            <a id="confirmAction" class="btn btn-approve">확인</a>
        </div>
    </div>
</div>

<script>
    function confirmApproval(vacationNo) {
        document.getElementById("modalMessage").innerText = "해당 휴가를 승인하시겠습니까?";
        document.getElementById("confirmAction").href = "vacationApproval.erp?vacation_no=" + vacationNo;
        document.getElementById("confirmModal").style.display = "block";
    }

    function confirmRejection(vacationNo) {
        document.getElementById("modalMessage").innerText = "해당 휴가를 반려하시겠습니까?";
        document.getElementById("confirmAction").href = "vacationReject.erp?vacation_no=" + vacationNo;
        document.getElementById("confirmModal").style.display = "block";
    }

    function closeModal() {
        document.getElementById("confirmModal").style.display = "none";
    }

    window.onclick = function(event) {
        const modal = document.getElementById("confirmModal");
        if (event.target === modal) {
            modal.style.display = "none";
        }
    }

    document.getElementById("searchInput").addEventListener("input", function () {
        let searchText = this.value.toLowerCase();
        document.querySelectorAll("tbody tr").forEach(row => {
            row.style.display = row.innerText.toLowerCase().includes(searchText) ? "" : "none";
        });
    });

    document.getElementById("statusFilter").addEventListener("change", function () {
        let filter = this.value;
        document.querySelectorAll("tbody tr").forEach(row => {
            let status = row.querySelector(".badge")?.innerText.trim();
            row.style.display = (filter === "" || status === filter) ? "" : "none";
        });
    });
</script>
