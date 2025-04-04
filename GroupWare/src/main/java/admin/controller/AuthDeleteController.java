package admin.controller;



import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import admin.model.AuthInfoDao;
import admin.model.CmmCodeDao;

@Controller
public class AuthDeleteController {
	
	private final String command ="auth_delete.erp";
	
	@Autowired
	AuthInfoDao authInfoDao;
	
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public void doAction(@RequestParam("auth_cd") String auth_cd,
						 HttpServletResponse response) throws IOException {
		
		
		
		int cnt = authInfoDao.deleteAuInfo(auth_cd);
		response.setContentType("text/plain;charset=UTF-8");
		response.getWriter().write("OK");
	}
	
	
}
