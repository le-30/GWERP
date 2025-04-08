package Login.controller;


import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import Login.model.LoginDao;
import employee.model.EmployeeDao;

@Controller
public class FindPassword {
	
	    @Autowired
	    EmployeeDao empDao;
	    
	    @Autowired
	    JavaMailSender mailSender;
	    
	    @Autowired
	    LoginDao loginDao;
	    
	    
	    //비밀번호 찾기 폼을 요청하는 방법
	    @RequestMapping(value = "/sendPwAuth.erp", method=RequestMethod.GET)
	    public String doAction() {
	    	
	    	
	    	return "/login/findPwForm";
	    }
	    
	    //이메일로 인증 코드 전송
	    @RequestMapping(value = "/sendPwAuth.erp", method=RequestMethod.POST)
	    public ModelAndView doAction(@RequestParam("emp_no") String emp_no,
	    							 @RequestParam("email")String email) {
	    	
	    	ModelAndView mav = new ModelAndView();
	    	Map<String,String> map = new HashMap<String,String>();
	    	map.put("email", email);
	    	map.put("emp_no", emp_no);
	    	
	    	boolean checkEmpEmail = empDao.checkEmployee(map);
	    	if(!checkEmpEmail) {
	    		mav.addObject("error","등록되지 않은 이메일 주소입니다.");
	    		mav.setViewName("/login/findPwForm");
	    		return mav;
	    	}
	    	
	    	 	String uuid = UUID.randomUUID().toString();
	    	    String code = String.valueOf((int)(Math.random() * 900000) + 100000); // 6�옄由�
	    	 try {
	    	        MimeMessage message = mailSender.createMimeMessage();
	    	        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

	    	        helper.setTo(email);
	    	        helper.setSubject("[GroupWare]비밀번호 인증 코드");
	    	        helper.setText("<p>비밀번호 인증 코드는 아래와 같습니다:</p><h2>" + code + "</h2>", true);

	    	        mailSender.send(message);
	    	        
	    	        Map<String, String> loginMap = new HashMap<String,String>();
	    	        loginMap.put("uuid", uuid);
	    	        loginMap.put("emp_no", emp_no);
	    	        loginMap.put("code", code);
	    	        loginDao.savePwAuthCode(loginMap);

	    	        mav.addObject("message", "등록된 이메일로 인증 코드를 발송했습니다.");
	    	        mav.addObject("uuid",uuid);

	    	    } catch (Exception e) {
	    	        e.printStackTrace();
	    	        mav.addObject("error", "이메일 발송에 실패하였습니다.");
	    	    }
	    	 	
	    	 	mav.setViewName("/login/certifyForm");
	    	    return mav;
	    
	    }
	    
		//인증 코드 확인
		@RequestMapping(value = "/verifyCode.erp", method = RequestMethod.POST)
		public ModelAndView verifyCode(@RequestParam("uuid") String uuid,
		                               @RequestParam("code") String code) {

		    ModelAndView mav = new ModelAndView();

		    Map<String, String> map = new HashMap<String,String>();
		    map.put("uuid", uuid);
		    map.put("code", code);

		
		    String emp_no = loginDao.getEmpIdByUuidAndCode(map);

		    if (emp_no == null) {
		        mav.setViewName("/login/certifyForm");
		        mav.addObject("error", "인증 코드가 일치하지 않습니다.");
		        mav.addObject("uuid", uuid); // �떎�떆 �씤利� �떆 �븘�슂
		        return mav;
		    }

		    
		    mav.setViewName("/login/resetPwForm");
		    mav.addObject("emp_no", emp_no);
		    mav.addObject("uuid", uuid);
		    return mav;
		}
		//비밀번호 재설정
		@RequestMapping(value = "/resetPwConfirm.erp", method = RequestMethod.POST)
		public ModelAndView resetPw(@RequestParam("uuid") String uuid,
		                            @RequestParam("emp_no") String emp_no,
		                            @RequestParam("newPw") String newPw,
		                            @RequestParam("confirmPw") String confirmPw) {

		    ModelAndView mav = new ModelAndView();

		    // 1. 비밀번호 확인
		    if (!newPw.equals(confirmPw)) {
		        mav.setViewName("/login/resetPwForm");
		        mav.addObject("error", "鍮꾨�踰덊샇媛� �씪移섑븯吏� �븡�뒿�땲�떎.");
		        mav.addObject("uuid", uuid);
		        mav.addObject("emp_no", emp_no);
		        return mav;
		    }

		    // 2. 비밀번호 변경
		    Map<String, String> map = new HashMap<String,String>();
		    map.put("emp_no", emp_no);
		    map.put("newPw", newPw);
		    empDao.updatePassword(map);

		    // 3. 인증 코드 삭제
		    loginDao.deletePwAuthCode(uuid);

		    // 4. 변경 완료 후 화면
		    mav.setViewName("/login/resetPwSuccess");
		    return mav;
		}

	    
}
