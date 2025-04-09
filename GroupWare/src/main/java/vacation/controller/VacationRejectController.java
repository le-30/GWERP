package vacation.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vacation.model.VacationDao;

@Controller
public class VacationRejectController {
	
	private final String command = "vacationReject.erp";
	private final String gotoPage = "redirect:/vacationList.erp";
	
	@Autowired
	private VacationDao vdao;
	
	@RequestMapping(command)
	public String reject(@RequestParam("vacation_no") String vacation_no,HttpSession session) {
		
		 String approver_position_cd = (String) session.getAttribute("position_cd"); // 승인자의 직급
	     String appr_emp_no = (String) session.getAttribute("emp_no"); // 승인자의 사원번호
	     
		vdao.VacationReject(vacation_no,appr_emp_no);
		
		return gotoPage;
		
		
	}
}
