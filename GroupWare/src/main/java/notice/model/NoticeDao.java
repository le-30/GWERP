package notice.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import utility.Paging;

@Service("ndao")
public class NoticeDao {

	private final String namespace="notice.model.Notice";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int getTotalCount(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(namespace +".getTotalCount", map);
		return cnt;
	}//getTotalCount
	
	public int getDeptCount(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(namespace +".getDeptCount", map);
		return cnt;
	}//getTotalCount
	
	public int getMyCount(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(namespace +".getMyCount", map);
		return cnt;
	}//getTotalCount

	public List<NoticeBean> selectAllNotice(Paging pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		List<NoticeBean> lists = sqlSessionTemplate.selectList(namespace + ".selectAllNotice", map, rowBounds);

		return lists;
	}//selectAllNotice
	
	public int writeNotice(NoticeBean notice) {
		int cnt = sqlSessionTemplate.insert(namespace + ".writeNotice", notice);
		System.out.println(cnt);
		return cnt;
	}//writeNotice

	public NoticeBean selectOneNotice(int notice_no) {
		int cnt = sqlSessionTemplate.update(namespace + ".updateReadcount", notice_no);
		System.out.println("조회수 올림");
		NoticeBean nb = sqlSessionTemplate.selectOne(namespace + ".selectOneNotice", notice_no);
		return nb;
	}//selectOneNotice

	public int updateNotice(NoticeBean notice) {
		int cnt = sqlSessionTemplate.update(namespace + ".updateNotice", notice);
		System.out.println(cnt);
		return cnt;
	}//updateNotice
	
	public int downReadcount(int notice_no) {
		int cnt = sqlSessionTemplate.update(namespace + ".downReadcount", notice_no);
		System.out.println("조회수 내림");
		return cnt;
	}//downReadcount

	public int deleteNotice(int notice_no) {
		int cnt = sqlSessionTemplate.delete(namespace + ".deleteNotice", notice_no);
		System.out.println(cnt);
		return cnt;
	}//deleteNotice

	public int saveNotice(NoticeBean notice) {
		int cnt = sqlSessionTemplate.insert(namespace + ".saveNotice", notice);
		System.out.println(cnt);
		return cnt;
	}//saveNotice

	public List<NoticeBean> selectNotice() {
		List<NoticeBean> lists = sqlSessionTemplate.selectList(namespace + ".selectNotice");
		return lists;
	}//selectNotice
	
	public List<NoticeBean> selectDeptNotice(Paging pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		List<NoticeBean> lists = sqlSessionTemplate.selectList(namespace + ".selectDeptNotice", map, rowBounds);
		return lists;
	}//selectDeptNotice

	public List<NoticeBean> selectSaveNotice() {
		List<NoticeBean> lists = sqlSessionTemplate.selectList(namespace + ".selectSaveNotice");
		return lists;
	}

	public String selectOneNum() {
		String notice_no_seq = sqlSessionTemplate.selectOne(namespace + ".selectOneNum");
		return notice_no_seq;
	}

	public List<NoticeBean> selectDeptPointNotice(String dept_nm) {
		List<NoticeBean> lists = sqlSessionTemplate.selectList(namespace + ".selectDeptPointNotice", dept_nm);
		return lists;
	}
	
	
	
}
