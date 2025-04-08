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


    // ï¿½Þ°ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½Þ¼ï¿½ï¿½ï¿½ (ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ emp_no ï¿½ß°ï¿½)
    public void vacationApproval(String vacation_no, String approver_emp_no) {
        java.util.Map<String, Object> param = new java.util.HashMap<String, Object>();
        param.put("vacation_no", vacation_no);
        param.put("approver_emp_no", approver_emp_no);
        sqlSessionTemplate.update(namespace + ".vacationApproval", param);
    }

    // ï¿½ï¿½Ã»ï¿½ï¿½ï¿½ï¿½ emp_no ï¿½ï¿½È¸ ï¿½Þ¼ï¿½ï¿½ï¿½ ï¿½ß°ï¿½
    public String getApplicantEmpNo(String vacation_no) {
        return sqlSessionTemplate.selectOne(namespace + ".getApplicantEmpNo", vacation_no);
    }

    // ÈÞ°¡ ÀÏ¼ö Á¶È¸ (°á°ú°¡ ÇÏ³ª¸¸ ³ª¿Àµµ·Ï)
    public int getVacationDays(String vacation_no) {
        return sqlSessionTemplate.selectOne(namespace + ".getVacationDays", vacation_no);
    }


	public int VacationReject(String vacation_no) {
		int cnt = sqlSessionTemplate.update(namespace + ".VacationReject" + vacation_no);
		
		return cnt;
	}

}
