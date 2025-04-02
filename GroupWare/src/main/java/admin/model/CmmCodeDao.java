package admin.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component("CmmCodeDao")
public class CmmCodeDao {
	
		private final String namespace = "admin.model.Admin";
		@Autowired
		SqlSessionTemplate sqlSessionTemplate;

		public List<CmmCodeBean> getAllCmmCode(Paging pageInfo, Map<String, String> map) {

			RowBounds rowBounds = new RowBounds(pageInfo.getOffset(),pageInfo.getLimit());
			List<CmmCodeBean> lists = sqlSessionTemplate.selectList(namespace+".getAllCmmCode",map,rowBounds);
			
			return lists;
		}

		public int insertCmmCode(CmmCodeBean cmmCodeBean) {
			
			int cnt = sqlSessionTemplate.insert(namespace+".insertCmmCode",cmmCodeBean);
			
			return cnt;
		}

		public CmmCodeBean getOneCmmCode(String cmm_nm) {
			
			CmmCodeBean cmmCodeBean = sqlSessionTemplate.selectOne(namespace+".getOneCmmCode",cmm_nm);
			
			return cmmCodeBean;
		}

		public int updateCmmCode(CmmCodeBean cmmCodeBean) {
			
			int cnt = sqlSessionTemplate.update(namespace+".updateCmmCode",cmmCodeBean);
			
			return cnt;
		}

		public int deleteCmmCode(String cmm_nm) {
			
			int cnt = sqlSessionTemplate.delete(namespace+".deleteCmmCode",cmm_nm);
			
			return cnt;
		}

		public int getTotalCountCmm(Map<String, String> map) {
			
			int cnt = sqlSessionTemplate.selectOne(namespace+".getTotalCountCmm",map);
			
			return cnt;
		}
		
}
