package notice.controller;

import javax.servlet.http.HttpServletRequest;
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

@Controller
public class NoticeWriteController {
	private final String command = "notice_write.erp";
	private final String getPage = "notice/notice_writeForm";
	private final String gotoPage = "redirect:/main.erp?page=totalNotice";
	private final String gotoPage2 = "redirect:/main.erp?page=totalNotice";
	private final String gotoPage3 = "redirect:/main.erp?page=totalNotice";
	
	@Autowired
	NoticeDao ndao;
	
	@Autowired
	AttachDao adao;
	
	FileUploadController fileUploadController = new FileUploadController();
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public ModelAndView doAction() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName(getPage);
		
		return mav;
	}
	
	@RequestMapping(value=command, method=RequestMethod.POST)
	public ModelAndView doAction(HttpServletRequest request,
								 @ModelAttribute("notice") @Valid NoticeBean notice,
								 BindingResult result,
								 @RequestParam("file") MultipartFile file,
                                 HttpServletResponse response) {
		
		String savedFileName = fileUploadController.uploadFile(file, response);
		
		ModelAndView mav = new ModelAndView();
		
		System.out.println("date"+notice.getNotice_dtm());
		System.out.println("notice_no"+notice.getNotice_title());
		System.out.println("title"+notice.getNotice_title());
		System.out.println("notice_content"+notice.getNotice_content());
		System.out.println("dept_nm"+notice.getDept_nm());
		System.out.println("emp_no"+notice.getEmp_no());
		System.out.println("emp_nm"+notice.getEmp_no());
		System.out.println("temporary_save"+notice.getTemporary_save());
		System.out.println("notice_level"+notice.getNotice_level());
		
		if(result.hasErrors()) {
			mav.setViewName(getPage);
			return mav;
		}
		
		int cnt = ndao.writeNotice(notice);
		
		String notice_no_seq = ndao.selectOneNum();
		
		System.out.println("notice_no_seq : " + notice_no_seq);
		
		if (file != null && !file.isEmpty()) {
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
		mav.setViewName(gotoPage);
		return mav;
	}
}
