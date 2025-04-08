package vacation.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vacation.model.VacationDao;

@Controller
public class VacationRejectController {
	
	private final String command = "vacationReject.erp";
	private final String gotoPage = "redirect:/approvalSignList.erp";
	
	@Autowired
	private VacationDao vdao;
	
	@RequestMapping(command)
	public String reject(@RequestParam("vacation_no") String vacation_no) {
		
		
		vdao.VacationReject(vacation_no);
		
		return gotoPage;
		
		
	}
}
