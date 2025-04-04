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

import admin.model.CmmCodeDao;

@Controller
public class CmmCodeDeleteController {
	
	private final String command ="cmmCode_delete.erp";
	
	@Autowired
	CmmCodeDao cmmCodeDao;
	
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public void doAction(@RequestParam("cmm_class") String cmm_class,
								 @RequestParam("cmm_cd") String cmm_cd,
								 HttpServletResponse response) throws IOException {
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("cmm_cd", cmm_cd);
		map.put("cmm_class", cmm_class);
		
		
		int cnt = cmmCodeDao.deleteCmmCode(map);
		response.setContentType("text/plain;charset=UTF-8");
		response.getWriter().write("OK");
	}
	
	
}
