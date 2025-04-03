package admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import admin.model.AuthInfoBean;
import admin.model.AuthInfoDao;
import admin.model.CmmCodeBean;
import admin.model.EmployeeAuthDao;
import employee.model.EmployeeBean;
import employee.model.EmployeeDao;
import utility.Paging;

@Controller
public class AuthManageController {
	
		private final String command = "/empAuthInfo.erp";
		private final String getPage = "admin/authInfo_listForm";
		
	@Autowired
	AuthInfoDao authInfodao;
	
	@Autowired
	EmployeeAuthDao empAuthdao;
	
	@Autowired
	EmployeeDao empdao;
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public ModelAndView doAction(@RequestParam(value="keyword",required= false)String keyword,
			 					 @RequestParam(value ="whatColumn", required =false)String whatColumn,
			 					 @RequestParam(value="pageNumber",required = false) String pageNumber,
			 					 HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Map<String, String> map = new HashMap<String,String>();
        map.put("whatColumn", whatColumn);
        map.put("keyword", "%" + keyword + "%");
        
        int totalCount = empdao.getTotalCount(map);
        String url = request.getContextPath() + command;
        Paging pageInfo = new Paging(pageNumber,"3",totalCount,url,whatColumn,keyword);
		
		List<AuthInfoBean> authList = authInfodao.getAllAuth();
		
		List<EmployeeBean> empList = empdao.getAllEmployeeJoinAuth(pageInfo,map);
		
		
		mav.addObject("authList",authList);
		mav.addObject("empList",empList);
		mav.addObject("pageInfo",pageInfo);
		mav.setViewName(getPage);
		return mav;
	}
	
	@RequestMapping(value=command, method=RequestMethod.POST)
	public String doAction(@RequestParam("auth_cd") String auth_cd,
	                       @RequestParam(value="emp_no", required=false) String[] empNo,
	                       @RequestParam(value="actionType", required=false) String actionType,
	                       HttpServletRequest request,
	                       HttpServletResponse response) throws IOException {

	    if (empNo != null) {
	        for (String emp_no : empNo) {
	            if ("grant".equals(actionType)) {
	                String alreadyAuth = empAuthdao.getAuthByEmpNo(emp_no, auth_cd);
	                if (alreadyAuth == null) {
	                    empAuthdao.insertEmployeeAuth(emp_no, auth_cd);
	                } else {
	                    empAuthdao.updateEmployeeAuth(emp_no, auth_cd);
	                }
	            } else if ("revoke".equals(actionType)) {
	                empAuthdao.deleteEmployeeAuth(emp_no, auth_cd);
	            }
	        }
	    }

	    // AJAX 요청이면 JSON 응답만 보내고 끝
	    if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
	        response.setContentType("text/plain;charset=UTF-8");
	        response.getWriter().write("success");
	        return null;
	    }

	    // 일반 submit일 경우 (거의 안 씀)
	    return "redirect:" + command;
	}
}
