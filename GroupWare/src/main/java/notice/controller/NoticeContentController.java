package notice.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import attach.model.AttachDao;
import notice.model.NoticeBean;
import notice.model.NoticeDao;
import reply.model.ReplyBean;
import reply.model.ReplyDao;

@Controller
public class NoticeContentController {
	private final String command = "notice_content.erp";
	private final String getPage = "notice/notice_content";
	
	@Autowired
	NoticeDao ndao;
	
	@Autowired
	ReplyDao rdao;
	
	@Autowired
	AttachDao adao;
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public ModelAndView doAction(@RequestParam("no") String notice_no,
			 					 @RequestParam(value="pageNumber", required = false) String pageNumber,
			 					 @RequestParam(value="whatColumn", required = false) String whatColumn,
			 					 @RequestParam(value="keyword", required = false) String keyword,
			 					 @RequestParam(value="kind", required = false) String kind) {
		
		
		
		NoticeBean nb = ndao.selectOneNotice(Integer.parseInt(notice_no));
		List<ReplyBean> lists = rdao.selectAllReply(Integer.parseInt(notice_no));
		
		String fileName = adao.selectFile(Integer.parseInt(notice_no));
		
		System.out.println("notice_no : " + notice_no);
		System.out.println("pageNumber : " + pageNumber);
		System.out.println("whatColumn : " + whatColumn);
		System.out.println("keyword : " + keyword);
		System.out.println("kind : " + kind);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("notice", nb);
		mav.addObject("fileName", fileName);
		mav.addObject("replyLists", lists);
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("whatColumn", whatColumn);
		mav.addObject("keyword", keyword);
		mav.addObject("kind", kind);
		mav.setViewName(getPage);
		
		return mav;
	}
}
