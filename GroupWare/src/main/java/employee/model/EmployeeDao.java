package employee.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component("EmployeeDao")
public class EmployeeDao {
		
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	private final String namespace="employee.model.Employee";
	
	public List<EmployeeBean> getAllEmployee(Paging pageInfo,Map<String,String> map) {
		
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(),pageInfo.getLimit());
		List<EmployeeBean> lists = sqlSessionTemplate.selectList(namespace+".getAllEmployee",map,rowBounds);
		
		return lists;
	}

	public int insertEmployee(EmployeeBean empBean) {
		
		int cnt = sqlSessionTemplate.insert(namespace+".insertEmployee",empBean);
		
		return cnt;
	}

	public EmployeeBean getEmployeeInfo(String emp_no, String pw) {
		
		EmployeeBean empBean = new EmployeeBean();
		empBean.setEmp_no(emp_no);
		empBean.setPw(pw);
		System.out.println("empBean.emp_no"+empBean.getEmp_no());
		System.out.println("empBean.pw"+empBean.getPw());
		
		empBean = sqlSessionTemplate.selectOne(namespace+".getEmployeeInfo",empBean);
		
		
		return empBean;
	}

	public List<EmployeeBean> getAllEmployeeJoinAuth() {
		
		List<EmployeeBean> empList = sqlSessionTemplate.selectList(namespace+".getAllEmployeeAuth");
		
		return empList;
	}

	public int getTotalCount(Map<String, String> map) {
		
		int cnt = sqlSessionTemplate.selectOne(namespace+".getTotalCount",map);
		
		return cnt;
	}

	public EmployeeBean getOneEmp(String emp_no) {
		
		EmployeeBean empBean = sqlSessionTemplate.selectOne(namespace+".getOneEmp",emp_no);
		
		return empBean;
	}

	public int updateEmployee(EmployeeBean empBean) {

		int cnt = sqlSessionTemplate.update(namespace+".updateEmployee",empBean);
		
		return cnt;
	}

	public List<EmployeeBean> getAllEmployeeList() {
		
		List<EmployeeBean> lists = sqlSessionTemplate.selectList(namespace+".getAllEmployeeList");
		
		return lists;
	}

	public boolean checkEmployee(Map<String, String> map) {
		
		int count = sqlSessionTemplate.selectOne(namespace + ".checkEmployee",map);
		
		return count == 1;
	}

	public void updatePassword(Map<String, String> map) {
		sqlSessionTemplate.update(namespace+".updatePassword",map);
		
	}

	public int updateAnnualLeave(String emp_no, int total_days) {
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("emp_no", emp_no);
	    map.put("total_days", total_days);

	    int result = sqlSessionTemplate.update(namespace + ".updateAnnualLeave", map);
	    
	    return result;
	}
	
    // 로그인한 사원의 연차 정보 조회 (연차만 가져오기)
    public EmployeeBean getEmployeeLeave(String emp_no) {
        return sqlSessionTemplate.selectOne(namespace + ".getEmployeeLeave", emp_no);
    }

    // 전체 사원의 연차 정보 조회
    public List<EmployeeBean> getAllEmployeeVacation() {
        return sqlSessionTemplate.selectList(namespace + ".getAllEmployeeVacation");
    }
	
}
