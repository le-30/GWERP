package salary.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import commute.model.CommuteBean;
import jwt.util.JwtUtil;
import salary.model.SalaryDao;

@Controller
public class SalaryController {

    @Autowired
    SalaryDao sdao;

    @RequestMapping("/salary/list.erp")
    public String list(@RequestParam(value = "month", required = false) String month,
                       @RequestParam(value = "type", required = false) String type,
                       @RequestParam(value = "keyword", required = false) String keyword,
                       @CookieValue("access_token") String token,
                       Model model) {


        String emp_no = JwtUtil.getEmp_no(token);
        String empNm = JwtUtil.getEmpNm(token);
        String cmmNm = JwtUtil.getCmmNm(token);
        String deptNm = JwtUtil.getDeptNm(token);

        
        Map<String, String> map = new HashMap<String, String>();
        map.put("emp_no", emp_no);
        map.put("month", month);
        map.put("type", type);
        map.put("keyword", "%" + (keyword == null ? "" : keyword) + "%");

        List<CommuteBean> lists;

        if ("사장".equals(cmmNm)) {
            lists = sdao.findAllForPresident(map);
        } else if ("인사팀".equals(deptNm)) {
            lists = sdao.findAllExcludingPresident(map); // 기존
        } else {
            lists = sdao.findByEmpId(map);
        }

        model.addAttribute("lists", lists); 
        model.addAttribute("empNm", empNm);
        model.addAttribute("cmmNm", cmmNm);
        model.addAttribute("deptNm", deptNm);
        model.addAttribute("type", type);
        model.addAttribute("keyword", keyword);
        model.addAttribute("month", month);
        System.out.println("month: " + month);

        System.out.println("급여 리스트 수: " + lists.size());
        for (CommuteBean c : lists) {
            System.out.println("사번: " + c.getEmp_no() + ", 이름: " + c.getEmpNm());
        }

        return "salary/salarylist";

    }
}