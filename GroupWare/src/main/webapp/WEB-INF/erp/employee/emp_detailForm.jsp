<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div style="max-width: 600px; margin: 0 auto; background: #fff; padding: 30px; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.08);">
    <h3 style="margin-bottom: 25px; text-align: center;">👤 사원 상세정보</h3>

    <div style="display: grid; grid-template-columns: 1fr 2fr; row-gap: 12px; column-gap: 20px; font-size: 15px;">
        <div style="font-weight: bold; text-align: right;">사원번호</div>
        <div>${empBean.emp_no}</div>

        <div style="font-weight: bold; text-align: right;">사원이름</div>
        <div>${empBean.emp_nm}</div>

        <div style="font-weight: bold; text-align: right;">상태</div>
        <div>${empBean.emp_status_nm}</div>

        <div style="font-weight: bold; text-align: right;">부서</div>
        <div>${empBean.dept_nm}</div>

        <div style="font-weight: bold; text-align: right;">직위</div>
        <div>${empBean.position_nm}</div>

        <div style="font-weight: bold; text-align: right;">입사일</div>
        <div>${empBean.hire_date}</div>

        <div style="font-weight: bold; text-align: right;">성별</div>
        <div>${empBean.gender_nm}</div>

        <div style="font-weight: bold; text-align: right;">생년월일</div>
        <div>${empBean.birth}</div>

        <div style="font-weight: bold; text-align: right;">이메일</div>
        <div>${empBean.email}</div>
    </div>

    <!-- 수정 버튼 -->
    <div style="text-align: center; margin-top: 30px;">
        <button class="open-edit-modal"
                data-url="emp_update.erp"
                data-id="${empBean.emp_no}"
                style="padding: 8px 16px; background-color: #3498db; color: white; border: none; border-radius: 6px; cursor: pointer;">
            수정
        </button>
    </div>

    <!-- 뒤로가기 -->
    <div style="display: flex; justify-content: flex-start; margin-top: 40px;">
	    <div style="max-width: 150px;">
	        <div class="sideTr"
	             data-action="page"
	             data-target="emp"
	             onclick="handleSidebar(this)"
	             style="cursor: pointer; color: #007bff; font-weight: bold; display: inline-block; padding: 6px 12px;">
	            <i class="fas fa-user sideIcon"></i> 사원정보
	            
				<!-- 유지해야 할 히든 값들 -->
		        <input type="hidden" value="${whatColumn}" name="whatColumn">
		        <input type="hidden" value="${keyword}" name="keyword">
		        <input type="hidden" value="${pageNumber}" name="pageNumber">
	        </div>
	    </div>
	</div>
</div>
