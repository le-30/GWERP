package notice.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import attach.controller.FileUploadController;
import attach.model.AttachBean;
import attach.model.AttachDao;
import notice.model.NoticeBean;
import notice.model.NoticeDao;
import reply.model.ReplyBean;
import reply.model.ReplyDao;

@Controller
public class NoticeUpdateController {
	private final String command = "notice_update.erp";
	private final String getPage = "notice/notice_UpdateForm";
	private final String gotoPage = "redirect:/notice_content.erp";
	
	@Autowired
	NoticeDao ndao;
	
	@Autowired
	AttachDao adao;
	
	@Autowired
	ReplyDao rdao;
	
	FileUploadController fileUploadController = new FileUploadController();
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public ModelAndView doAction(@RequestParam("no") int notice_no,
			 					 @RequestParam(value="pageNumber") String pageNumber,
			 					 @RequestParam(value="whatColumn",required = false) String whatColumn,
			 					 @RequestParam(value="keyword",required = false) String keyword,
			 					 @RequestParam(value="kind",required = false) String kind) {
		
		String fileName = adao.selectFile(notice_no);
		
		NoticeBean nb = ndao.selectOneNotice(notice_no);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("notice", nb);
		mav.addObject("fileName", fileName);
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("whatColumn", whatColumn);
		mav.addObject("keyword", keyword);
		mav.addObject("kind", kind);
		mav.setViewName(getPage);
		
		return mav;
	}
	
	@RequestMapping(value=command, method=RequestMethod.POST)
	public ModelAndView doAction(@ModelAttribute("notice") @Valid NoticeBean notice, BindingResult result,
								 @RequestParam(value="pageNumber",required = false) String pageNumber,
								 @RequestParam(value="whatColumn",required = false) String whatColumn,
								 @RequestParam(value="keyword",required = false) String keyword,
								 @RequestParam("file") MultipartFile file,
								 HttpServletResponse response) {
		
		String savedFileName = fileUploadController.uploadFile(file, response);
		
		ModelAndView mav = new ModelAndView();
		
		if(result.hasErrors()) {
        	mav.addObject("pageNumber", pageNumber);
            mav.addObject("whatColumn", whatColumn);
            mav.addObject("keyword", keyword);
			mav.setViewName(getPage);
			return mav;
		}
		
		int cnt = ndao.updateNotice(notice);
		
		String notice_no_seq = ndao.selectOneNum();
		
		System.out.println("notice_no_seq : " + notice_no_seq);
		
		if (file != null && !file.isEmpty()) {
			
			int cnt2 = adao.deleteFail(notice_no_seq);
			
            AttachBean attach = new AttachBean();
            attach.setCon_key2(notice_no_seq); // 臾몄꽌 踰덊샇 �뿰寃�
            attach.setOrg_file_name(file.getOriginalFilename());// �썝蹂� �뙆�씪紐�
            attach.setServer_file_name(savedFileName); // ���옣�맂 �뙆�씪紐�
            attach.setFile_size(file.getSize()); // �뙆�씪 �겕湲�
            
            System.out.println("�썝蹂� �뙆�씪 �씠由� : " + file.getOriginalFilename());
            System.out.println("�꽌踰� �뙆�씪 �씠由�: " + attach.getServer_file_name());  // �뙆�씪 �씠由꾩쓣 異쒕젰

            int attachInsertCount = adao.insertAttach(attach);
            if (attachInsertCount > 0) {
                System.out.println("첨부 파일 정보 저장 성공");
            } else {
                System.out.println("첨부 파일 정보 저장 실패");
            }
		}
		
		System.out.println("notice_no() : " + notice.getNotice_no());
		System.out.println("notice_no_seq : " + notice_no_seq);
		System.out.println("file.getOriginalFilename() : " + file.getOriginalFilename());
		System.out.println("pageNumber : " + pageNumber);
		System.out.println("whatColumn : " + whatColumn);
		System.out.println("keyword : " + keyword);
		
		ndao.downReadcount(notice.getNotice_no());
		ndao.downReadcount(notice.getNotice_no());
		
		
		
		
		mav.addObject("notice_no", notice.getNotice_no());
		mav.addObject("notice_no", notice.getNotice_no());
        mav.addObject("pageNumber", pageNumber);
        mav.addObject("whatColumn", whatColumn);
        mav.addObject("keyword", keyword);
        mav.setViewName(gotoPage);
        
		return mav;
	}
}
