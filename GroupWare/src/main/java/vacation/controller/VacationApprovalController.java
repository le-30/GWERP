package vacation.controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import employee.model.EmployeeDao;
import vacation.model.VacationDao;

@Controller
public class VacationApprovalController {

    // 요청 URL과 리다이렉트할 페이지 정의
    private final String command = "vacationApproval.erp";  // 요청 URL 매핑
    private final String gotoPage = "vacation/vacationList";  // 승인 후 이동할 페이지

    // VacationDao 객체 자동 주입
    @Autowired
    private VacationDao vdao;
    
    @Autowired
    private EmployeeDao edao;

    @RequestMapping(command)
    public String vacationApproval(@RequestParam("vacation_no") String vacation_no, HttpSession session) throws Exception {
        
        // 1️⃣ 세션에서 승인자의 정보 가져오기
        String approver_position_cd = (String) session.getAttribute("position_cd"); // 승인자의 직급
        String approver_emp_no = (String) session.getAttribute("emp_no"); // 승인자의 사원번호

        System.out.println("vacation_no : " + vacation_no);
        System.out.println("approver_position_cd : " + approver_position_cd);
        System.out.println("approver_emp_no : " + approver_emp_no);

        // 2️⃣ 승인 권한 확인 (직급이 4보다 작은 경우에만 승인 가능)
        if (Integer.parseInt(approver_position_cd) < 4) {
            
            // 3️⃣ vacation_no를 기준으로 휴가 신청한 직원의 emp_no 조회
            String applicant_emp_no = vdao.getApplicantEmpNo(vacation_no);
            System.out.println("휴가 신청자 emp_no : " + applicant_emp_no);

            // 4️⃣ 휴가 승인 처리 (승인자 emp_no를 함께 전달)
            vdao.vacationApproval(vacation_no, approver_emp_no);

            // 5️⃣ 휴가 일수 가져오기
            int total_days = vdao.getVacationDays(vacation_no);
            System.out.println("휴가 일수 : " + total_days);

            // 6️⃣ 신청자의 연차 차감
            edao.updateAnnualLeave(applicant_emp_no, total_days);
            System.out.println("연차 차감 완료");

            return gotoPage;
        } else {
            throw new Exception("승인할 수 없는 직급입니다.");
        }
    }
}

