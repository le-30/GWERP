package vacation.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import vacation.model.VacationBean;
import vacation.model.VacationDao;


@Controller
public class VacationRequestController {
	
	private final String command = "vacation_insert.erp";
	private final String getPage = "vacation/vacationRequest";
	private final String gotoPage = "redirect:/vacationList.erp"; // ���� �� �̵��� ������
	
	@Autowired
	private VacationDao vdao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String showVacationForm() {
		return getPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView submitVacationRequest(@ModelAttribute("vacation") @Valid VacationBean vacation, 
			BindingResult result, HttpSession session) {  
		
		ModelAndView mav = new ModelAndView();

		// ��ȿ�� �˻� üũ
		if (result.hasErrors()) {
			mav.setViewName(getPage);
			return mav;
		}

		// ���ǿ��� emp_no �����ͼ� Bean�� ����
		String emp_no = (String) session.getAttribute("emp_no");
		

	
		 // �α� Ȯ�� 
		  System.out.println("vacation_no: " + vacation.getVacation_no());
		  System.out.println("vacation_type: " + vacation.getVacation_type());
		  System.out.println("vacation_reason: " + vacation.getVacation_reason());
		  System.out.println("vacation_status: " + vacation.getVacation_status());
		  System.out.println("start_dt: " + vacation.getStart_dt());
		  System.out.println("end_dt: " + vacation.getEnd_dt());

		// DB ����
		int cnt = vdao.insertVacation(vacation);

		if (cnt > 0) {
			mav.setViewName(gotoPage);
		} else {
			mav.setViewName(getPage); // ���� ���� �� ������ ����
		}

		return mav;
	}
}
