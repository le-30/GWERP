package Login.controller;


import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import employee.model.EmployeeBean;
import employee.model.EmployeeDao;
import jwt.util.JwtUtil;

@Controller
public class SubmitLoginController {
	private final String command ="/lsh_login.erp";
	private final String getPage ="login/loginForm";
	private final String gotoPage ="main/main";


	@Autowired
	EmployeeDao empdao;


	@RequestMapping(value=command,method=RequestMethod.GET)
	public String doAction(){

		return getPage;
	}

	@RequestMapping(value=command,method=RequestMethod.POST) 
	public ModelAndView doAction(@RequestParam("emp_no") String emp_no,
								 @RequestParam("pw") String pw,
								 HttpSession session,
								 HttpServletResponse response) {

		ModelAndView mav = new ModelAndView();

		EmployeeBean empBean = empdao.getEmployeeInfo(emp_no, pw);

		System.out.println("emp_no:"+empBean.getEmp_no());
		System.out.println("pw:"+empBean.getPw());

		if(empBean.getEmp_no().equals(emp_no) && empBean.getPw().equals(pw)) {

			session.setAttribute("emp_no", emp_no);
			session.setAttribute("emp_nm",empBean.getEmp_nm());
			session.setAttribute("dept_cd", empBean.getDept_cd());
			session.setAttribute("dept_nm", empBean.getDept_nm());          
			session.setAttribute("position_cd", empBean.getPosition_cd());
			session.setAttribute("position_nm", empBean.getPosition_nm()); 

			String accessToken = JwtUtil.createToken(emp_no, empBean.getPosition_nm(), empBean.getDept_nm());

			response.setHeader("Set-Cookie", "access_token=" + accessToken + "; Path=/; HttpOnly; Max-Age=54000"); // 15�ð�

			mav.addObject("emp_no",emp_no);
			mav.setViewName("redirect:/check_in/commute.erp?access_token="+accessToken);
			
			
			mav.setViewName(gotoPage);
			return mav;
		}else {
			System.out.println("����");
			mav.setViewName(getPage);
			return mav;
		}
	}
}
