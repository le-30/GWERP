package vacation.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import utility.Paging;

@Repository
public class VacationDao {

	private final String namespace = "vacation.model.Vacation";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;


	public int insertVacation(VacationBean vacation) {
		int cnt = sqlSessionTemplate.insert(namespace + ".insertVaction", vacation);

		return cnt;
	}


	public int getTotalCount(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(namespace + ".getTotalCount", map);
		return cnt;
	}


	public List<VacationBean> getVacationList(Paging pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());

		List<VacationBean> VacationList = sqlSessionTemplate.selectList(namespace + ".getVacationList", map, rowBounds);
		return VacationList;
	}


    // 휴가 승인 메서드 (승인자의 emp_no 추가)
    public void vacationApproval(String vacation_no, String approver_emp_no) {
        java.util.Map<String, Object> param = new java.util.HashMap<>();
        param.put("vacation_no", vacation_no);
        param.put("approver_emp_no", approver_emp_no);
        sqlSessionTemplate.update(namespace + ".vacationApproval", param);
    }

    // 신청자의 emp_no 조회 메서드 추가
    public String getApplicantEmpNo(String vacation_no) {
        return sqlSessionTemplate.selectOne(namespace + ".getApplicantEmpNo", vacation_no);
    }

    // 휴가 일수 조회 (결과가 하나만 나오도록)
    public int getVacationDays(String vacation_no) {
        return sqlSessionTemplate.selectOne(namespace + ".getVacationDays", vacation_no);
    }

}
