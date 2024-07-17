package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.SchoolEmployeeVO;

public interface ManagerEmpService {

	public List<SchoolEmployeeVO> empList(Map<String, Object> map);

	public int getTotal(Map<String, Object> map);

	public String schEmNo(Map<String, Object> map);

	public int createAjax(Map<String, Object> map);

	public List<Map<String, Object>> salaryList();

	public List<Map<String, Object>> univList();
}
