package approval.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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

import approval.model.ApprovalBean;
import approval.model.ApprovalDao;
import attach.controller.FileUploadController;
import attach.model.AttachBean;
import attach.model.AttachDao;
import document.model.DocumentBean;
import document.model.DocumentDao;

@Controller
public class ApprovalRequestController {

    // URL 경로 정의
    private final String command = "approval_insert.erp"; // 결제 요청 폼 제출 경로
    private final String getPage = "approval/approval_insert"; // 결제 요청 폼 페이지
    private final String gotoPage = "redirect:/approvalList.erp?page=appr"; // 결제 요청 완료 후 리디렉션할 페이지
    
    @Autowired
    private DocumentDao documentDao; // 문서 관련 DAO
    
    @Autowired
    private ApprovalDao approvalDao;
    
    @Autowired
    private AttachDao attachDao;
    
    
    FileUploadController fileUploadController = new FileUploadController(); 
    // GET 요청: 결제 요청 폼 페이지로 이동
    @RequestMapping(value = command, method = RequestMethod.GET)
    public String showApprovalRequestForm() {
        return getPage; // 결제 요청 폼을 보여주는 JSP 페이지로 이동
    }

    // POST 요청: 결제 요청 처리
    @RequestMapping(value = command, method = RequestMethod.POST)
    public ModelAndView submitApprovalRequest(@ModelAttribute("document") @Valid DocumentBean document,  
                                              BindingResult result,
                                              HttpSession session,
                                              @RequestParam("file") MultipartFile file,
                                              HttpServletResponse response	  ) {
    	String savedFileName = fileUploadController.uploadFile(file, response);
    	
        String positionCdFromSession = (String) session.getAttribute("position_cd");
        String emp_no = (String) session.getAttribute("emp_no");
        String dept_cd = (String) session.getAttribute("dept_cd");
        if (positionCdFromSession != null) {
            document.setPosition_cd(positionCdFromSession);
        }
        ModelAndView mav = new ModelAndView();

        // 유효성 검사 후 오류가 있다면 폼 페이지를 다시 보여줌
        if (result.hasErrors()) {
            mav.setViewName(getPage);
            return mav;
        }

      
        // 결제 요청을 문서정보 테이블에 삽입
        System.out.println("doc_title: " + document.getDoc_title());
        System.out.println("doc_content: " + document.getDoc_content());
        System.out.println("emp_no: " + document.getEmp_no());
        System.out.println("dept_cd: " + document.getDept_cd());
        System.out.println("position_cd: " + document.getPosition_cd());
        System.out.println("1: " + document.getAppr_status());
        
        
        int cnt = documentDao.insertDocument(document);  // 문서 정보 삽입
        
        
        String doc_no_seq = documentDao.selectOneNum();
        if (cnt > 0) {
            System.out.println("생성된 doc_no: " + doc_no_seq);
            
            ApprovalBean approval = new ApprovalBean();
            approval.setDoc_no(doc_no_seq);  // 문서 번호
            approval.setAppr_order(1);       // 예시로 결제 순서 1
            approval.setEmp_no(document.getEmp_no());
            approval.setDept_cd(document.getDept_cd());
            approval.setPosition_cd(document.getPosition_cd());
            approval.setAppr_status("대기");
            approval.setAppr_dtm(null);  // 결제 일시 (현재 시간)
            approval.setAppr_refuse_op("1");  // 반려 사유 없음

            // appr_line 테이블에 결제 라인 삽입
            int lineInsertCount = approvalDao.insertApprovalLine(approval);
            

            if (lineInsertCount > 0) {
                System.out.println("결제 라인 추가 성공");
            } else {
                System.out.println("결제 라인 추가 실패");
            }
            
            if (file != null && !file.isEmpty()) {
                AttachBean attach = new AttachBean();
                attach.setCon_key3(doc_no_seq); // 문서 번호 연결
                attach.setOrg_file_name(file.getOriginalFilename());// 원본 파일명
                attach.setServer_file_name(savedFileName); // 저장된 파일명
                attach.setFile_size(file.getSize()); // 파일 크기
                
                System.out.println("원본 파일 이름 : " + file.getOriginalFilename());
                System.out.println("서버 파일 이름: " + attach.getServer_file_name());  // 파일 이름을 출력

                int attachInsertCount = attachDao.insertAttach(attach);
                if (attachInsertCount > 0) {
                    System.out.println("첨부 파일 정보 저장 성공");
                } else {
                    System.out.println("첨부 파일 정보 저장 실패");
                }
            }
            mav.setViewName(gotoPage);  // 결제 요청이 완료된 후 결제 요청 목록 페이지로 리디렉션
        } else {
            mav.setViewName(getPage);  // 문서 삽입 실패 시 폼 페이지로 돌아감
        }

        return mav;
    }
}
