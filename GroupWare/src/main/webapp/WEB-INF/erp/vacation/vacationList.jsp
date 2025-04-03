<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Bootstrap & Custom Styles -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

<style>
body {
    background-color: #f8f9fa;
}

.container {
    max-width: 1200px;
}

h2 {
    font-weight: bold;
    color: #343a40;
    border-bottom: 3px solid #007bff;
    display: inline-block;
    padding-bottom: 5px;
    margin-bottom: 20px;
}

table {
    border-radius: 10px;
    overflow: hidden;
}

thead {
    background: linear-gradient(135deg, #007bff, #0056b3);
    color: white;
    text-transform: uppercase;
}

tbody tr {
    transition: all 0.3s ease-in-out;
}

tbody tr:nth-child(odd) {
    background-color: #f2f2f2;
}

tbody tr:hover {
    transform: scale(1.02);
    background-color: #e3f2fd;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

/* 버튼 및 기타 스타일 */
.badge {
    font-size: 14px;
    padding: 6px 12px;
    border-radius: 12px;
}

.btn {
    font-weight: bold;
    transition: 0.3s ease-in-out;
}

.btn-success:hover {
    background-color: #218838;
    box-shadow: 0 4px 10px rgba(40, 167, 69, 0.4);
}

.btn-danger:hover {
    background-color: #c82333;
    box-shadow: 0 4px 10px rgba(220, 53, 69, 0.4);
}

.paging {
    text-align: center;
    margin-top: 20px;
}
</style>

<div class="container mt-5">
    <h2>휴가 신청 목록</h2>

    <!-- 검색 및 필터 -->
    <div class="row mb-3">
        <div class="col-md-4">
            <input type="text" class="form-control" placeholder="신청자 검색..." id="searchInput">
        </div>
        <div class="col-md-4">
            <select class="form-control" id="statusFilter">
                <option value="">상태 선택</option>
                <option value="승인">승인</option>
                <option value="반려">반려</option>
                <option value="대기">대기</option>
            </select>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-hover table-bordered text-center align-middle shadow-sm">
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
                <!-- 리스트가 비었을 때 메시지 출력 -->
                <c:if test="${empty vacationList}">
                    <tr>
                        <td colspan="9" class="text-center text-muted">현재 신청된 휴가가 없습니다.</td>
                    </tr>
                </c:if>

                <!-- 리스트가 있을 때 휴가 목록 출력 -->
                <c:if test="${not empty vacationList}">
                    <c:forEach var="vacation" items="${vacationList}">
                        <tr>
                            <td>${vacation.vacation_no}</td>
                            <td>${vacation.vacation_type}</td>
                            <td>${vacation.req_emp_no}</td>
                            <td>
                                <span class="text-primary"><fmt:formatDate value="${vacation.start_dt}" pattern="yyyy-MM-dd"/></span> 
                                ~ 
                                <span class="text-danger"><fmt:formatDate value="${vacation.end_dt}" pattern="yyyy-MM-dd"/></span>
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
                            <td>
                                <button class="btn btn-success btn-sm" onclick="confirmApproval(${vacation.vacation_no})">✔ 승인</button>
                            </td>
                            <td>
                                <button class="btn btn-danger btn-sm" onclick="confirmRejection(${vacation.vacation_no})">❌ 반려</button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
            </tbody>
        </table>
    </div>

    <!-- 페이징 -->
    <div class="paging">
        ${pageInfo.pagingHtml}
    </div>
</div>

<!-- 승인/반려 모달 -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">확인</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p id="modalMessage"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <a id="confirmAction" class="btn btn-primary">확인</a>
            </div>
        </div>
    </div>
</div>
       
<script>
    function confirmApproval(vacationNo) {
        document.getElementById("modalMessage").innerText = "해당 휴가를 승인하시겠습니까?";
        document.getElementById("confirmAction").href = "vacationApproval.erp?vacation_no=" + vacationNo;
        new bootstrap.Modal(document.getElementById("confirmModal")).show();
    }

    function confirmRejection(vacationNo) {
        document.getElementById("modalMessage").innerText = "해당 휴가를 반려하시겠습니까?";
        document.getElementById("confirmAction").href = "vacationReject.erp?vacation_no=" + vacationNo;
        new bootstrap.Modal(document.getElementById("confirmModal")).show();
    }

    document.getElementById("searchInput").addEventListener("input", function() {
        let searchText = this.value.toLowerCase();
        document.querySelectorAll("tbody tr").forEach(row => {
            row.style.display = row.innerText.toLowerCase().includes(searchText) ? "" : "none";
        });
    });

    document.getElementById("statusFilter").addEventListener("change", function() {
        let filter = this.value;
        document.querySelectorAll("tbody tr").forEach(row => {
            let status = row.querySelector(".badge")?.innerText.trim();
            row.style.display = (filter === "" || status === filter) ? "" : "none";
        });
    });
</script>
