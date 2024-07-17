package kr.or.ddit.service.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.ComAttachDetVO;
import kr.or.ddit.vo.ComAttachFileVO;
import kr.or.ddit.vo.StuAttachFileVO;

@Repository
public class AttachDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public int insertFileAttach(ComAttachFileVO comAttachFileVO) {
		return this.sqlSessionTemplate.insert("attach.insertFileAttach",comAttachFileVO);
	}

	public int insertDetAttach(ComAttachDetVO comAttachDetVO) {
		return this.sqlSessionTemplate.insert("attach.insertDetAttach",comAttachDetVO);
	}

	public int insertStuAttach(StuAttachFileVO stuAttachFileVO) {
		return this.sqlSessionTemplate.insert("attach.insertStuAttach",stuAttachFileVO);
	}
}
