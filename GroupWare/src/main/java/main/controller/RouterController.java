package main.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
 
@Controller
public class RouterController {
	
	private final String command ="/router.erp";
	private final String gotoPage ="main/main";
	
	@RequestMapping(command)
	public String doAction(@RequestParam("page") String page,
							@RequestParam(value="whatColumn", required = false) String whatColumn,
							@RequestParam(value="keyword", required = false) String keyword,
							@RequestParam(value="pageNumber", required = false) String pageNumber) throws UnsupportedEncodingException {
		
		System.out.println("router whatColumn : " + whatColumn);
		System.out.println("router keyword : " + keyword);
		System.out.println("router pageNumber : " + pageNumber);
		
		String encodedKeyword = (keyword != null) ? URLEncoder.encode(keyword, "UTF-8") : "";
		String encodedWhatColumn = (whatColumn != null) ? URLEncoder.encode(whatColumn, "UTF-8") : "";
		    
		String queryParams = String.format("?whatColumn=%s&keyword=%s&pageNumber=%s",
	            encodedWhatColumn,
	            encodedKeyword,
	            pageNumber != null ? pageNumber : "1");
		
		if ("emp".equals(page)) {
		    return "redirect:/lsh_list.erp";
		}else if("dept".equals(page)){
			return "redirect:/dept_list.erp" +queryParams;
		}else if("cmmCode".equals(page)){
			return "redirect:/cmm_list.erp" + queryParams;
		}else if("authInfo".equals(page)) {
			
			return "redirect:/empAuthInfo.erp" +queryParams;
		}else if("auth".equals(page)) {
			return "redirect:/auth_list.erp"+ queryParams;
		}else if("received".equals(page)) {
			return "redirect:/ymh_MessageReceive.erp";
		}else if("send".equals(page)) {
			return "redirect:/ymh_MessageSend.erp";
		}else if("totalNotice".equals(page)){
			return "redirect:/notice_list.erp";
		} else if("appr".equals(page)){
			return "redirect:/approvalList.erp";
		} else if("apprList".equals(page)) {
			return "redirect:/approvalSignList.erp";
		} else if("apprSuc".equals(page)) {
			return "redirect:/approvalComplete.erp";
		}if("vacation".equals(page)) {
			return "redirect:/vacationList.erp";
		} else if("vacationApproval".equals(page)) {
			return "redirect:/vacationList.erp";
		} else if("vacationleave".equals(page)){
			return "redirect:/employeeVacation.erp";
		}
		else {
		    return gotoPage;
		}
	}
}
