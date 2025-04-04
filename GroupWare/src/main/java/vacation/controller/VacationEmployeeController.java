package vacation.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import employee.model.EmployeeBean;
import employee.model.EmployeeDao;

@Controller
public class VacationEmployeeController {

    private final String command = "employeeVacation.erp";  // 연차 조회 페이지

    private final String gotoPage = "vacation/employeeVacation";  

    @Autowired
    private EmployeeDao edao;

    @RequestMapping(command)
    public String showVacationList(HttpSession session, Model model) {
        String emp_no = (String) session.getAttribute("emp_no");

        // 현재 로그인한 사원의 기본 정보 조회
        EmployeeBean empBean = edao.getOneEmp(emp_no);
        if (empBean != null) {
            model.addAttribute("employee", empBean);
        }

        // 현재 로그인한 사원의 연차 정보만 조회
        EmployeeBean leaveBean = edao.getEmployeeLeave(emp_no);
        if (leaveBean != null) {
            model.addAttribute("leaveInfo", leaveBean);
        }

        // 전체 사원 연차 목록 조회
        List<EmployeeBean> employeeList = edao.getAllEmployeeVacation();
        model.addAttribute("employeeList", employeeList);

        return gotoPage;
    }
}
