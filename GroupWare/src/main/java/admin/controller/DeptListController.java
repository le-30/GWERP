package admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import admin.model.DeptBean;
import admin.model.DeptDao;
import utility.Paging;

@Controller
public class DeptListController {
	
		private final String command = "/dept_list.erp";
		private final String gotoPage = "admin/dept_listForm";
		
		@Autowired
		DeptDao deptDao;
		
		@RequestMapping(command)
		public ModelAndView doAction(@RequestParam(value="keyword",required= false)String keyword,
				 					 @RequestParam(value ="whatColumn", required =false)String whatColumn,
				 					 @RequestParam(value="pageNumber",required = false) String pageNumber,
				 					 HttpServletRequest request) {
			
			ModelAndView mav = new ModelAndView();
			
			Map<String, String> map = new HashMap<String,String>();
	        map.put("whatColumn", whatColumn);
	        map.put("keyword", "%" + keyword + "%");
	        
			System.out.println("whatColumn : " + whatColumn);
			System.out.println("keyword : " + keyword);
	        
	        int totalCount = deptDao.getTotalCount(map);
	        
	        String url = request.getContextPath() + command;
	        
	        Paging pageInfo = new Paging(pageNumber,"3", totalCount, url, whatColumn, keyword);
	        System.out.println("url : " + url);
	        System.out.println("totalCount: " + totalCount);
	        System.out.println("pageNumber: " + pageNumber);
	        System.out.println("whatColumn: " + whatColumn);
	        System.out.println("keyword: " + keyword);
	         
	    	// ★ 여기 추가! ★
	    	System.out.println("pageInfo.getStart(): " + pageInfo.getBeginRow());
	    	System.out.println("pageInfo.getEnd(): " + pageInfo.getEndRow());

	    	// 4. 리스트 조회 (start, end 넣어서)
	    	map.put("start", String.valueOf(pageInfo.getBeginRow()));
	    	map.put("end", String.valueOf(pageInfo.getEndRow()));
	    	
			List<DeptBean> lists = deptDao.getAllDept(pageInfo,map);
			System.out.println("lists : " + lists.size());
			

			mav.addObject("lists",lists);
			mav.addObject("pageInfo", pageInfo);
	        mav.addObject("totalCount", totalCount);
			mav.setViewName(gotoPage);
			
			return mav;
		}
		
}
