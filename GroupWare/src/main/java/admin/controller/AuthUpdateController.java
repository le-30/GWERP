package admin.controller;


import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import admin.model.AuthInfoBean;
import admin.model.AuthInfoDao;
import admin.model.CmmCodeBean;
import admin.model.CmmCodeDao;

@Controller
public class AuthUpdateController {
	
	private final String command ="auth_update.erp";
	private final String getPage ="admin/auth_updateForm";
	private final String gotoPage ="redirect:/main.erp?page=auth";
	
	@Autowired
	AuthInfoDao authInfoDao;
	
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public ModelAndView doAction(@RequestParam("id") String auth_cd) {
		
		ModelAndView mav = new ModelAndView();
		AuthInfoBean authInfoBean = authInfoDao.getOneAuthCode(auth_cd);
		
		mav.addObject("authInfoBean",authInfoBean);
		mav.setViewName(getPage);
		return mav;
	}
	
	@RequestMapping(value=command,method=RequestMethod.POST)
	public ModelAndView doActioin(@ModelAttribute("authInfoBean") @Valid AuthInfoBean authInfoBean,BindingResult result) {
		
		ModelAndView mav = new ModelAndView();
		if(result.hasErrors()) {
			
			mav.addObject("authInfoBean", authInfoBean);
			mav.setViewName(getPage);
			return mav;
		}
		
		int cnt = authInfoDao.updateAuthInfo(authInfoBean);
		mav.setViewName(gotoPage);
		
		return mav;
	}
}
