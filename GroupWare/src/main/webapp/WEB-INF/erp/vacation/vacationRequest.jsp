<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<% 
    String emp_no = (String) session.getAttribute("emp_no"); 
    System.out.println("emp_no : " +  emp_no);
%>
<script>
function validateCheckbox() {
    let vacationType = document.querySelector('input[name="vacation_type"]:checked');
    
    if (!vacationType) {
        alert("�ް� ������ �����ϼ���.");
        return false;
    }
    return true;
}
</script>

<!-- �ް� ��û �� -->

<form action="vacation_insert.erp" method="post" onsubmit="return validateCheckbox()">
    <!-- hidden �ʵ�� ��� ��ȣ ���� -->
    <input type="hidden" name="emp_no" value="${sessionScope.emp_no}">
    <h2>�ް� ��û</h2>

    <label>�ް� ����</label><br>
    <input type="radio" name="vacation_type" value="����"> ����
    <input type="radio" name="vacation_type" value="����"> ����
    <input type="radio" name="vacation_type" value="����"> ����
    <input type="radio" name="vacation_type" value="��Ÿ"> ��Ÿ <br><br>
    
    <label>��� ��ȣ : </label>
    <input type="text" name="req_emp_no" value="${sessionScope.emp_no}" readonly><br><br>

    <label>�ް� ����:</label><br>
    <textarea name="vacation_reason" rows="4" cols="50"></textarea><br><br>

    <label>������:</label>
    <input type="date" name="start_dt"><br><br>

    <label>������:</label>
    <input type="date" name="end_dt"><br><br>

    <!-- ���� ��ư -->
    <input type="submit" value="��û">
</form>


