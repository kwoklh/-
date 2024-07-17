package kr.or.ddit.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.ComCodeVO;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class AdminStudentDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public List<ComDetCodeVO> deptList() {
		return this.sqlSessionTemplate.selectList("adminStudent.deptList");
	}

	public List<StudentVO> stdList(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectList("adminStudent.stdList",map);
	}

	public int getTotal() {
		return this.sqlSessionTemplate.selectOne("adminStudent.getTotal");
	}

	public StudentVO detail(String stNo) {
		//stNo >>> 1651001
		return this.sqlSessionTemplate.selectOne("adminStudent.detail",stNo);
	}

	public int updateStd(Map<String, Object> map) {
		return this.sqlSessionTemplate.update("adminStudent.updateStd",map);
	}

	public int updateStdStat(Map<String, Object> map) {
		return this.sqlSessionTemplate.update("adminStudent.updateStdStat",map);
	}

	public List<ComCodeVO> getCollege() {
		return this.sqlSessionTemplate.selectList("adminStudent.getCollege");
	}

	public List<ComDetCodeVO> getDept(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectList("adminStudent.getDept",map);
	}

	public String getStNo(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectOne("adminStudent.getStNo",map);
	}

	public List<ProfessorVO> getProfList(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectList("adminStudent.getProfList", map);
	}
}
