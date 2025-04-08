package main.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DashBoardController {

	 @RequestMapping("/dashboard.erp")
	    public String dashboard(Model model, HttpSession session) {
	        // 필요한 데이터 모델에 담기 (예: 공지사항 최신 3개 등)
	        return "main/dashboard"; // dashboard.jsp
	    }
	}