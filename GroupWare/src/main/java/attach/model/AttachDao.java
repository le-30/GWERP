package attach.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AttachDao {
	
	private final String namespace = "attach.model.Attach";
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    // 泥⑤��뙆�씪 �궫�엯 硫붿꽌�뱶
    public int insertAttach(AttachBean attach) {
        // 泥⑤��뙆�씪 �젙蹂대�� �뜲�씠�꽣踰좎씠�뒪�뿉 �궫�엯
        return sqlSessionTemplate.insert(namespace + ".insertAttach", attach);
    }

    
	public String getServerFileNameByDocNo(String doc_no) {
		
		return sqlSessionTemplate.selectOne(namespace + ".getServerFileNameByDocNo", doc_no);
	}
	
	
	public String getServerFileNameByNoticeNo(String notice_no) {
		
		return sqlSessionTemplate.selectOne(namespace + ".getServerFileNameByNoticeNo", notice_no);
	}


	public String getServerFileNameByMessageNo(String msg_no) {
		
		return sqlSessionTemplate.selectOne(namespace + ".getServerFileNameByMessageNo", msg_no);
	}

	public AttachBean getOneSelect(String msg_no) {
		
		AttachBean attach = sqlSessionTemplate.selectOne(namespace + ".getOneSelect",msg_no);
		
		return attach;
	}
	
	
	public int deleteFail(String notice_no) {
		
		int cnt = sqlSessionTemplate.delete(namespace + ".deleteFail",notice_no);
		System.out.println("delect cnt : " + cnt);
		
		return cnt;
	}


	public String selectFile(int notice_no) {
		
		String fileName = sqlSessionTemplate.selectOne(namespace + ".selectFile",notice_no);
		
		return fileName;
	}
	
	
}
