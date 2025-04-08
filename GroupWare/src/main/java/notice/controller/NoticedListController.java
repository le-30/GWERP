package notice.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import notice.model.NoticeBean;
import notice.model.NoticeDao;
import utility.Paging;

@Controller
public class NoticedListController {
	private final String command = "/notice_dlist.erp";
	private final String getPage = "notice/notice_dept_listForm";
	
	@Autowired
	NoticeDao ndao;
	
	@RequestMapping(command)
	public ModelAndView doAction(@RequestParam(value = "whatColumn", required = false) String whatColumn,
								 @RequestParam(value = "keyword", required = false) String keyword,
								 @RequestParam(value = "pageNumber", required = false) String pageNumber,
								 HttpServletRequest request,
								 HttpSession session) {
		
		String dept_nm = (String)session.getAttribute("dept_nm");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%" + keyword + "%");
		map.put("dept_nm", dept_nm);
		
		System.out.println("whatColumn : " + whatColumn);
		System.out.println("keyword : " + keyword);
		
		int totalCount = ndao.getDeptCount(map);
		
		String url = request.getContextPath() + "/" + command;
		
		Paging pageInfo = new Paging(pageNumber, "10", totalCount, url, whatColumn, keyword);
		
		List<NoticeBean> lists0 = ndao.selectAllNotice(pageInfo, map);
		System.out.println("lists0 : " + lists0.size());
		
		List<NoticeBean> lists1 = ndao.selectNotice();
		System.out.println("lists1 : " + lists1.size());
		
		List<NoticeBean> lists2 = ndao.selectSaveNotice();
		System.out.println("lists2 : " + lists2.size());
		
		List<NoticeBean> lists3 = ndao.selectDeptNotice(pageInfo, map);
		System.out.println("lists3 : " + lists3.size());
		
		List<NoticeBean> lists4 = ndao.selectDeptPointNotice(dept_nm);
		System.out.println("lists4 : " + lists4.size());
		
		ModelAndView mav = new ModelAndView(); 
		mav.addObject("noticeLists3", lists3);
		mav.addObject("noticeLists4", lists4);
		mav.addObject("totalCount", totalCount);
		mav.addObject("pageInfo", pageInfo);
		mav.setViewName(getPage);
		return mav;
	}
}
