package admin.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("EmployeeAuthDao")
public class EmployeeAuthDao {
	
	private final String namespace = "admin.model.Admin";
		@Autowired
		SqlSessionTemplate sqlSessionTemplate;

		public String getAuthByEmpNo(String emp_no,String auth_cd) {
			
			Map<String,String> map = new HashMap<String,String>();
			map.put("auth_cd", auth_cd);
			map.put("emp_no", emp_no);
			String getAuthByEmpNo = sqlSessionTemplate.selectOne(namespace+".getAuthByEmpNo",map);
			
			return getAuthByEmpNo;
		}

		public int insertEmployeeAuth(String emp_no, String auth_cd) {
			
			Map<String,String> map = new HashMap<String,String>();
			map.put("auth_cd", auth_cd);
			map.put("emp_no", emp_no);
			
			int cnt = sqlSessionTemplate.insert(namespace+".insertEmployeeAuth",map);
			
			return cnt;
		}

		public int updateEmployeeAuth(String emp_no, String auth_cd) {
			Map<String,String> map = new HashMap<String,String>();
			map.put("auth_cd", auth_cd);
			map.put("emp_no", emp_no);
			int cnt = sqlSessionTemplate.update(namespace+".updateEmployeeAuth",map);
			
			return cnt;
		}

		public int deleteEmployeeAuth(String emp_no, String auth_cd) {
			Map<String,String> map = new HashMap<String,String>();
			map.put("auth_cd", auth_cd);
			map.put("emp_no", emp_no);
			int cnt = sqlSessionTemplate.delete(namespace+".deleteEmployeeAuth",map);
			return cnt;
		}

		public List<String> getAuthNamesByEmpNo(String emp_no) {
			List<String> authlists = sqlSessionTemplate.selectList(namespace+".getAuthNamesByEmpNo",emp_no);
			return authlists;
		}
}
