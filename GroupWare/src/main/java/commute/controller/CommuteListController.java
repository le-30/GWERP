package commute.controller;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import commute.model.CommuteBean;
import commute.model.CommuteDao;
import jwt.util.JwtUtil;
import utility.Paging;

@org.springframework.stereotype.Controller
public class CommuteListController {

	@Autowired
	CommuteDao cdao;


	@RequestMapping("/check_in/commute.erp")
	public String checkIn(@CookieValue(value = "access_token", required = false) String token,
			Model model) {

		String emp_no = JwtUtil.getEmp_no(token);
		String empNm=JwtUtil.getEmpNm(token);
		String deptNm = JwtUtil.getDeptNm(token);
		String cmmNm = JwtUtil.getCmmNm(token);



		Timestamp currentTimestamp = new java.sql.Timestamp(System.currentTimeMillis());
		String workDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(currentTimestamp);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("work_date", workDate); 
		map.put("emp_no", emp_no);
		map.put("empNm", empNm);
		map.put("deptNm", deptNm);
		map.put("cmmNm", cmmNm);

		CommuteBean cb = cdao.selectOne(map); 

		if (cb == null) {
			cdao.check_in(map);
			return "redirect:/main.erp"; 
		}

		if (cb.getClock_in() != null) {
			return "redirect:/main.erp";  
		} else {
			cdao.check_in(map);
			return "redirect:/main.erp"; 
		}
	}


	@RequestMapping("/list/commute.erp")
	public String list(HttpServletRequest request,
			@CookieValue("access_token") String token,
			@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value="pageNumber", required = false) String pageNumber,
			Model model) {

		String emp_no = JwtUtil.getEmp_no(token);
		String empNm = JwtUtil.getEmpNm(token);
		String cmmNm = JwtUtil.getCmmNm(token);
		String deptNm = JwtUtil.getDeptNm(token);

		Map<String, String> map=new HashMap<String, String>();
		map.put("emp_no", emp_no);
		map.put("empNm", empNm);
		map.put("cmmNm", cmmNm);
		map.put("deptNm", deptNm);
		map.put("whatColumn", whatColumn); 
		map.put("keyword", "%"+keyword+"%");

		List<CommuteBean> lists;

		if ("사장".equals(cmmNm)) {
			lists = cdao.findAll(map);
		} else if ("인사팀".equals(deptNm)) {
			lists = cdao.findAllExcludingPresident(map);
		} else if ("부장".equals(cmmNm)) {
			lists = cdao.findByDepartmentExcludingPresident(map);
		} else {
			lists = cdao.findByEmpId(emp_no);
		}

		int totalCount = cdao.getTotalCount(map);
		String url = request.getContextPath() + "/commute.erp";
		Paging pageInfo = new Paging(pageNumber,"10",totalCount,url,whatColumn,keyword);
		model.addAttribute("lists", lists);
		model.addAttribute("emp_no", emp_no);
		model.addAttribute("empNm", empNm);
		model.addAttribute("cmmNm", cmmNm);
		model.addAttribute("deptNm", deptNm);
		model.addAttribute("pageInfo",pageInfo);
		return "commute/list";
	}
	@RequestMapping("/check_out/commute.erp")
	public String checkOut(@CookieValue("access_token") String token,
			Model model) {

		String emp_no = JwtUtil.getEmp_no(token);

		Timestamp currentTimestamp = new java.sql.Timestamp(System.currentTimeMillis());
		String workDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(currentTimestamp);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("work_date", workDate);
		map.put("emp_no", emp_no);

		System.out.println("work_date: " + workDate);

		cdao.check_out(map);
		return "redirect:/worktime/commute.erp";
	}  

	@RequestMapping("/worktime/commute.erp")
	   public String WorkTime(@CookieValue("access_token") String token,
	         Model model) {

	      String emp_no = JwtUtil.getEmp_no(token);
	      String workDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new Date());

	      Map<String, Object> map = new HashMap<String, Object>();
	      map.put("emp_no", emp_no);
	      map.put("work_date", workDate);

	      CommuteBean cb = cdao.selectOne(map);
	      Date clockIn = cb.getClock_in();
	      Date clockOut = cb.getClock_out();

	      Map<String, Double> timeMap = calculateDecimalWorkTimes(clockIn, clockOut);

	      map.put("total_hours", timeMap.get("total_hours"));
	      map.put("overtime_hours", timeMap.get("overtime_hours"));

	      cdao.wortktime(map);
	      return "redirect:/logout.erp";
	   }




	private Map<String, Double> calculateDecimalWorkTimes(Date clockIn, Date clockOut) {
	    long diffMillis = clockOut.getTime() - clockIn.getTime();
	    int totalMinutes = (int) (diffMillis / (1000 * 60));

	    double totalHours = totalMinutes / 60.0;

	    int overMinutes = Math.max(totalMinutes - (9 * 60), 0);
	    double overtimeHours = overMinutes / 60.0;

	    Map<String, Double> result = new HashMap<String, Double>();
	    result.put("total_hours", Math.round(totalHours * 100.0) / 100.0);
	    result.put("overtime_hours", Math.round(overtimeHours * 100.0) / 100.0);

	    return result;
	}

}