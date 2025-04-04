package notice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import notice.model.NoticeDao;

@Controller
public class NoticeDeleteController {
	private final String command = "notice_delete.erp";
	private final String getPage1 = "redirect:/notice_alist.erp";
	private final String getPage2 = "redirect:/notice_dlist.erp";
	private final String getPage3 = "redirect:/notice_mlist.erp";
	
	@Autowired
	NoticeDao ndao;
	
	@RequestMapping(command)
	public ModelAndView doAction(@RequestParam("no") int notice_no,
			 					 @RequestParam(value="pageNumber") int pageNumber,
			 					 @RequestParam(value="whatColumn",required = false) String whatColumn,
			 					 @RequestParam(value="keyword",required = false) String keyword,
			 					 @RequestParam(value="kind", required = false) String kind,
			 					 @RequestParam(value="reply_no", required = false) String reply_no) {
		
		int cnt = ndao.deleteNotice(notice_no);
		ModelAndView mav = new ModelAndView();
		
		if(kind.equals("total")) {
			mav.setViewName(getPage1);
		}else if(kind.equals("dept")) {
			mav.setViewName(getPage2);
		}else if(kind.equals("my")) {
			mav.setViewName(getPage3);
		}
		
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("whatColumn", whatColumn);
		mav.addObject("keyword", keyword);
		mav.addObject("kind", kind);
		
		return mav;
	}
	
}
