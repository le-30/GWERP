package salary.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import commute.model.CommuteBean;

@Component
public class SalaryDao {

    private String namespace = "salary.model.SalaryDao";

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    public List<CommuteBean> findAllForPresident(Map<String, String> map) {
    	return sqlSessionTemplate.selectList(namespace + ".findAllForPresident", map);
    }
    public List<CommuteBean> findAllExcludingPresident(Map<String, String> map) {
        return sqlSessionTemplate.selectList(namespace + ".findAllExcludingPresident", map);
    }

    public List<CommuteBean> findByEmpId(Map<String, String> map) {
        return sqlSessionTemplate.selectList(namespace + ".findByEmpId", map);
    }
}