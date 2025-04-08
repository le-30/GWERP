package vacation.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import utility.Paging;
import vacation.model.VacationBean;
import vacation.model.VacationDao;

@Controller
public class VacationListController {

    private final String command = "vacationList.erp";  // URL ����
    private final String getPage = "vacation/vacationList";  // JSP ���� ��ġ

    @Autowired
    VacationDao vdao;  // VacationDao ��ü ����

    @RequestMapping(command)
    public ModelAndView vacationList(HttpSession session, HttpServletRequest request, 
            @RequestParam(value = "pageNumber", required = false) String pageNumber,
            @RequestParam(value = "whatColumn", required = false) String whatColumn,
            @RequestParam(value = "keyword", required = false) String keyword) {
        
        // ���ǿ��� �α����� ����� ��� ��ȣ ��������
        String emp_no = (String) session.getAttribute("emp_no");
        
        // �˻��� �÷��� Ű���带 �ʿ� ����
        Map<String, String> map = new HashMap<String, String>();
        map.put("whatColumn", whatColumn);
        map.put("keyword", "%" + keyword + "%");
        map.put("emp_no", emp_no);
        
        System.out.println("whatColumn: " + whatColumn);
        System.out.println("keyword: " + keyword);
        System.out.println("emp_no: " + emp_no);
        
        // ��ü ����� ���� ���ϱ� ���� ����
        int totalCount = vdao.getTotalCount(map);
        
        // ���������̼� ó��
        String url = request.getContextPath() + "/" + command;
        Paging pageInfo = new Paging(pageNumber, "5", totalCount, url, whatColumn, keyword);
        
        // �ش� �������� �´� �ް� ��� ��ȸ 
        List<VacationBean> vacationList = vdao.getVacationList(pageInfo, map);
        
        // ModelAndView ��ü ���� �� ������ ����
        ModelAndView mav = new ModelAndView();
        mav.addObject("totalCount", totalCount);
        mav.addObject("vacationList", vacationList);
        mav.addObject("pageInfo", pageInfo);
        
        // JSP ��� �̵�
        mav.setViewName(getPage);
        return mav;
    }
}