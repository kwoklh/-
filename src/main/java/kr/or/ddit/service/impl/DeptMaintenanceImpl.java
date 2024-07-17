package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.dao.DeptMaintenanceDao;
import kr.or.ddit.service.DeptMaintenanceService;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.ProfessorVO;

@Service
public class DeptMaintenanceImpl implements DeptMaintenanceService{
	
	@Autowired
	DeptMaintenanceDao deptMaintenanceDao;

	@Override
	public List<ComDetCodeVO> getDeptList(Map<String, Object> map) {
		return this.deptMaintenanceDao.getDeptList(map);
	}

	@Override
	public List<ProfessorVO> getDataList(Map<String, Object> map) {
		return this.deptMaintenanceDao.getDataList(map);
	}
}
