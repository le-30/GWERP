package admin.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component("AuthInfoDao")
public class AuthInfoDao {

		private final String namespace = "admin.model.Admin";
		
		@Autowired
		SqlSessionTemplate sqlSessionTemplate;

		public List<AuthInfoBean> getAllAuthInfo(Paging pageInfo, Map<String,String> map) {
			
			RowBounds rowBounds = new RowBounds(pageInfo.getOffset(),pageInfo.getLimit());
			List<AuthInfoBean> authList = sqlSessionTemplate.selectList(namespace+".getAllAuthInfo",map,rowBounds);
			
			return authList;
		}

		public int insertAuth(AuthInfoBean authBean) {

				int cnt = sqlSessionTemplate.insert(namespace+".insertAuth",authBean);
			return cnt;
		}

		public int deleteAuInfo(String auth_cd) {
			
			int cnt = sqlSessionTemplate.delete(namespace+".deleteAuthInfo",auth_cd);
			
			return cnt;
		}

		public int getTotalCountAuth(Map<String, String> map) {
			
			int cnt = sqlSessionTemplate.selectOne(namespace+".getTotalCountAuth",map);
			
			return cnt;
		}

		public List<AuthInfoBean> getAllAuth() {
			List<AuthInfoBean> authlists = sqlSessionTemplate.selectList(namespace+".getAllAuth");
			return authlists;
		}
}
