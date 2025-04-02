package admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import admin.model.DeptBean;
import admin.model.DeptDao;

@Controller
public class DeptInsertController {
	
	private final String command ="dept_insert.erp";
	private final String getPage ="admin/dept_insertForm";
	private final String gotoPage ="redirect:/main.erp?page=dept";
	
	@Autowired
	DeptDao deptDao;
	
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public ModelAndView doAction(@RequestParam(value="keyword",required= false)String keyword,
			 					 @RequestParam(value ="whatColumn", required =false)String whatColumn,
			 					 @RequestParam(value="pageNumber",required = false) String pageNumber,
			 					 HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		List<DeptBean> lists= deptDao.getDeptCd();
		mav.addObject("lists",lists);
		mav.setViewName(getPage);
		return mav;
	}
	
	@RequestMapping(value=command,method=RequestMethod.POST)
	public ModelAndView doActioin(@ModelAttribute("deptBean") @Valid DeptBean deptBean,BindingResult result) {
		
		ModelAndView mav = new ModelAndView();
		if(result.hasErrors()) {
			
			List<DeptBean> lists = deptDao.getDeptCd();
			mav.addObject("lists",lists);
			mav.addObject("deptBean", deptBean);
			mav.setViewName(getPage);
			return mav;
		}
		int cnt = deptDao.insertDept(deptBean);
		mav.setViewName(gotoPage);
		
		return mav;
	}
}
