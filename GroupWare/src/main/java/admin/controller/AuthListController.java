package admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import admin.model.AuthInfoBean;
import admin.model.AuthInfoDao;
import admin.model.CmmCodeBean;
import utility.Paging;

@Controller
public class AuthListController {

	
		private final String command = "/auth_list.erp";
		private final String gotoPage = "admin/auth_listForm";
		
		@Autowired
		AuthInfoDao authInfoDao;
		
		@RequestMapping(value=command, method=RequestMethod.GET)
		public ModelAndView doAction(@RequestParam(value="keyword",required= false)String keyword,
									 @RequestParam(value ="whatColumn", required =false)String whatColumn,
									 @RequestParam(value="pageNumber",required = false) String pageNumber,
									 HttpServletRequest request) {
			ModelAndView mav = new ModelAndView();
			Map<String, String> map = new HashMap<String,String>();
	        map.put("whatColumn", whatColumn);
	        map.put("keyword", "%" + keyword + "%");
	        
	        int totalCount = authInfoDao.getTotalCountAuth(map);
	        String url = request.getContextPath() + command;
	        Paging pageInfo = new Paging(pageNumber,"3",totalCount,url,whatColumn,keyword);
			
			List<AuthInfoBean> authList = authInfoDao.getAllAuthInfo(pageInfo,map);
			
			
			mav.addObject("authList",authList);
			mav.addObject("pageInfo", pageInfo);
	        mav.addObject("totalCount", totalCount);
			mav.setViewName(gotoPage);
			return mav;
		}
		
	
		
}
