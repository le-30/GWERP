package reply.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import notice.model.NoticeDao;
import reply.model.ReplyBean;
import reply.model.ReplyDao;

@Controller
public class ReplyWriteController {
	private final String command = "reply_write.erp";
	private final String getPage = "notice/notice_content";
	private final String gotoPage = "redirect:/notice_content.erp";
	
	@Autowired
	ReplyDao rdao;
	
	@Autowired
	NoticeDao ndao;
	
	@RequestMapping(command)
	public ModelAndView doAction(@ModelAttribute("reply") @Valid ReplyBean reply,
								 BindingResult result,
								 @RequestParam(value="pageNumber") int pageNumber,
			 					 @RequestParam("whatColumn") String whatColumn,
			 					 @RequestParam("keyword") String keyword,
			 					 @RequestParam(value="kind", required = false) String kind) {
		
		ModelAndView mav = new ModelAndView();
		
		System.out.println("re_content : "+reply.getReply_content());
		System.out.println("re_notice_no : "+reply.getNotice_no());
		System.out.println("re_Emp_no : "+reply.getEmp_no());
		System.out.println("re_Emp_nm : "+reply.getEmp_nm());
		System.out.println("re_Reply_dtm : "+reply.getReply_dtm());
		
		if(result.hasErrors()) {
			mav.setViewName(getPage);
			return mav;
		}
		
		int cnt = rdao.writeReply(reply);
		ndao.downReadcount(reply.getNotice_no());
		mav.addObject("no", reply.getNotice_no());
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("whatColumn", whatColumn);
		mav.addObject("keyword", keyword);
		mav.addObject("kind", kind);
		mav.setViewName(gotoPage);
		return mav;
	}
}
