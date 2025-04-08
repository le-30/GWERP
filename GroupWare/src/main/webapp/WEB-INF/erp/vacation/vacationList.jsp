<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file=".././common/common.jsp"%>

<div style="background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
    <h4 style="margin-bottom: 20px;">📝 휴가 신청 목록</h4>

    <div style="margin-bottom: 20px; display: flex; gap: 10px;">
        <input type="text" id="searchInput" placeholder="신청자 검색..." style="padding: 6px 10px; border: 1px solid #ccc; border-radius: 5px;">
        <select id="statusFilter" style="padding: 6px 10px; border: 1px solid #ccc; border-radius: 5px;">

            <option value="">상태 선택</option>
            <option value="✔ 승인">승인</option>
            <option value="❌ 반려">반려</option>
            <option value="⌛ 대기">대기</option>
        </select>
    </div>


    <c:if test="${empty vacationList}">
        <div style="text-align: center; padding: 20px; border: 1px solid #eee;">현재 신청된 휴가가 없습니다.</div>
    </c:if>

    <c:if test="${not empty vacationList}">
        <!-- 헤더 -->
        <div style="display: grid; grid-template-columns: 1fr 1.2fr 1.2fr 2.5fr 1fr 1fr 1fr 0.8fr 0.8fr; font-weight: bold; background: #f0f0f0; padding: 10px; border-bottom: 2px solid #ccc;">
            <div>번호</div>
            <div>유형</div>
            <div>신청자</div>
            <div>기간</div>
            <div>일수</div>
            <div>상태</div>
            <div>승인자</div>
            <div>승인</div>
            <div>반려</div>
        </div>

        <!-- 목록 -->
        <c:forEach var="vacation" items="${vacationList}">
            <div style="display: grid; grid-template-columns: 1fr 1.2fr 1.2fr 2.5fr 1fr 1fr 1fr 0.8fr 0.8fr; padding: 10px; border-bottom: 1px solid #eee; align-items: center;">
                <div>${vacation.vacation_no}</div>
                <div>${vacation.vacation_type}</div>
                <div>${vacation.req_emp_no}</div>
                <div>
                    <span style="color: #007bff;">
                        <fmt:formatDate value="${vacation.start_dt}" pattern="yyyy-MM-dd"/>
                    </span> ~ 
                    <span style="color: #dc3545;">
                        <fmt:formatDate value="${vacation.end_dt}" pattern="yyyy-MM-dd"/>
                    </span>
                </div>
                <div>${vacation.total_days}</div>
                <div>
                    <c:choose>
                        <c:when test="${vacation.vacation_status == '승인'}">✔ 승인</c:when>
                        <c:when test="${vacation.vacation_status == '반려'}">❌ 반려</c:when>
                        <c:otherwise>⌛ 대기</c:otherwise>
                    </c:choose>
                </div>
                <div>${vacation.appr_emp_no}</div>
                <div><a href="javascript:void(0)" onclick="confirmApproval(${vacation.vacation_no})" style="color: green; font-weight: bold;">✔</a></div>
                <div><a href="javascript:void(0)" onclick="confirmRejection(${vacation.vacation_no})" style="color: red; font-weight: bold;">❌</a></div>
            </div>
        </c:forEach>
    </c:if>

    <div style="margin-top: 20px; text-align: center;">

        ${pageInfo.pagingHtml}
    </div>
</div>

<!-- 모달 -->

<div id="confirmModal" style="display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.4);">
    <div style="background: white; width: 400px; margin: 15% auto; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.3);">
        <div style="font-weight: bold; margin-bottom: 10px;">확인</div>
        <div style="margin-bottom: 20px;"><p id="modalMessage"></p></div>
        <div style="text-align: right;">
            <button onclick="closeModal()" style="margin-right: 10px; padding: 5px 10px;">취소</button>
            <a id="confirmAction" style="padding: 5px 10px; background: green; color: white; text-decoration: none; border-radius: 5px;">확인</a>

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

        document.querySelectorAll("div[style*='grid-template-columns']").forEach(row => {
            if (!row.innerText.toLowerCase().includes(searchText)) {
                row.style.display = "none";
            } else {
                row.style.display = "grid";
            }

        });
    });

    document.getElementById("statusFilter").addEventListener("change", function () {
        let filter = this.value;

        document.querySelectorAll("div[style*='grid-template-columns']").forEach(row => {
            let statusCell = row.children[5]?.innerText.trim();
            if (filter === "" || statusCell === filter) {
                row.style.display = "grid";
            } else {
                row.style.display = "none";
            }

        });
    });
</script>
