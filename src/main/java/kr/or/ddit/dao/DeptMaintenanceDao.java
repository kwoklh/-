package kr.or.ddit.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.ProfessorVO;

@Repository
public class DeptMaintenanceDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public List<ComDetCodeVO> getDeptList(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectList("maintenance.getDeptList", map);
	}

	public List<ProfessorVO> getDataList(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectList("maintenance.getDataList", map);
	}

}
