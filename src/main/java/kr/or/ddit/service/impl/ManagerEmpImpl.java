package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.dao.ManagerEmpDao;
import kr.or.ddit.service.ManagerEmpService;
import kr.or.ddit.vo.SchoolEmployeeVO;

@Service
public class ManagerEmpImpl implements ManagerEmpService {

	@Autowired
	ManagerEmpDao managerEmpDao;
	
	@Override
	public List<SchoolEmployeeVO> empList(Map<String, Object> map) {
		return this.managerEmpDao.empList(map);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.managerEmpDao.getTotal(map);
	}

	@Override
	public String schEmNo(Map<String, Object> map) {
		return this.managerEmpDao.schEmNo(map);
	}

	@Override
	public int createAjax(Map<String, Object> map) {
		return this.managerEmpDao.createAjax(map);
	}

	@Override
	public List<Map<String, Object>> salaryList() {
		return this.managerEmpDao.salaryList();
	}

	@Override
	public List<Map<String, Object>> univList() {
		return this.managerEmpDao.univList();
	}
	
}
