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
public class NoticemListController {
	private final String command = "/notice_mlist.erp";
	private final String getPage = "notice/notice_my_listForm";
	
	@Autowired
	NoticeDao ndao;
	
	@RequestMapping(command)
	public ModelAndView doAction(@RequestParam(value = "whatColumn", required = false) String whatColumn,
								 @RequestParam(value = "keyword", required = false) String keyword,
								 @RequestParam(value = "pageNumber", required = false) String pageNumber,
								 HttpServletRequest request,
								 HttpSession session) {
		
		String emp_no = (String)session.getAttribute("emp_no");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%" + keyword + "%");
		map.put("emp_no", emp_no);
		
		System.out.println("whatColumn : " + whatColumn);
		System.out.println("keyword : " + keyword);
		
		int totalCount = ndao.getMyCount(map);
		
		String url = request.getContextPath() + "/" + command;
		
		Paging pageInfo = new Paging(pageNumber, "10", totalCount, url, whatColumn, keyword);
		
		List<NoticeBean> lists0 = ndao.selectAllNotice(pageInfo, map);
		System.out.println("lists0 : " + lists0.size());
		
		List<NoticeBean> lists1 = ndao.selectNotice();
		System.out.println("lists1 : " + lists1.size());
		
		List<NoticeBean> lists2 = ndao.selectSaveNotice();
		System.out.println("lists2 : " + lists2.size());
		
		ModelAndView mav = new ModelAndView(); 
		mav.addObject("noticeLists0", lists0);
		mav.addObject("noticeLists1", lists1);
		mav.addObject("noticeLists2", lists2);
		mav.addObject("totalCount", totalCount);
		mav.addObject("pageInfo", pageInfo);
		mav.setViewName(getPage);
		return mav;
	}
}
