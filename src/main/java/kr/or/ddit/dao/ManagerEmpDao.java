package kr.or.ddit.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.SchoolEmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ManagerEmpDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public List<SchoolEmployeeVO> empList(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectList("schEmp.empList", map);
	}

	public int getTotal(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectOne("schEmp.getTotal", map);
	}

	public String schEmNo(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectOne("schEmp.schEmNo", map);
	}

	public int createAjax(Map<String, Object> map) {
		return this.sqlSessionTemplate.insert("schEmp.createAjax", map);
	}

	public List<Map<String, Object>> salaryList() {
		return this.sqlSessionTemplate.selectList("schEmp.salaryList");
	}

	public List<Map<String, Object>> univList() {
		return this.sqlSessionTemplate.selectList("schEmp.univList");
	}

}
