package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.ProfessorVO;

public interface DeptMaintenanceService {

	public List<ComDetCodeVO> getDeptList(Map<String, Object> map);

	public List<ProfessorVO> getDataList(Map<String, Object> map);
	
}
