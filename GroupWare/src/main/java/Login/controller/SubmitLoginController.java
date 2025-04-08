package Login.controller;


import java.util.List;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import admin.model.EmployeeAuthDao;
import employee.model.EmployeeBean;
import employee.model.EmployeeDao;
import jwt.util.JwtUtil;
import utility.AutoAuthority;

@Controller
public class SubmitLoginController {
	private final String command ="/lsh_login.erp";
	private final String getPage ="login/loginForm";
	private final String gotoPage ="main/main";


	@Autowired
	EmployeeDao empdao;
	
	@Autowired
	EmployeeAuthDao empAuthDao;

	@Autowired
	AutoAuthority autoAuthority;

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
		
		if (empBean == null) {
			mav.addObject("error", "�궗踰덉씠 議댁옱�븯吏� �븡嫄곕굹 鍮꾨�踰덊샇媛� ���졇�뒿�땲�떎.");
			mav.setViewName(getPage);
			return mav;
		}


		if(empBean.getEmp_no().equals(emp_no) && empBean.getPw().equals(pw)) {
			
			autoAuthority.defaultAuthor(empBean);
			
			session.setAttribute("emp_no", emp_no);
			session.setAttribute("emp_nm",empBean.getEmp_nm());
			session.setAttribute("dept_cd", empBean.getDept_cd());
			session.setAttribute("dept_nm", empBean.getDept_nm());          
			session.setAttribute("position_cd", empBean.getPosition_cd());
			session.setAttribute("position_nm", empBean.getPosition_nm()); 

			String accessToken = JwtUtil.createToken(emp_no, empBean.getEmp_nm(),empBean.getPosition_nm(), empBean.getDept_nm());
			System.out.println("accessToken:"+accessToken);
			
			 List<String> authNames = empAuthDao.getAuthNamesByEmpNo(emp_no);
		     session.setAttribute("currentAuth", String.join(",", authNames));
		     session.setAttribute("hasAdmin", authNames.contains("관리자권한"));


			response.setHeader("Set-Cookie", "access_token=" + accessToken + "; Path=/; HttpOnly; Max-Age=54000"); // 15�뜝�떆怨ㅼ삕

			mav.addObject("emp_no",emp_no);
			mav.setViewName("redirect:/check_in/commute.erp?access_token="+accessToken);
			
			
			return mav;
		}else {
			mav.setViewName(getPage);
			return mav;
		}
	}
}