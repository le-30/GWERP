package main.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DashBoardController {

	 @RequestMapping("/dashboard.erp")
	    public String dashboard(Model model, HttpSession session) {
	        // �ʿ��� ������ �𵨿� ��� (��: �������� �ֽ� 3�� ��)
	        return "main/dashboard"; // dashboard.jsp
	    }
	}