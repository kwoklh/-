package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ComCodeVO;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;

public interface AdminStudentService {

	public List<ComDetCodeVO> deptList();

	public List<StudentVO> stdList(Map<String, Object> map);

	public int getTotal();

	public StudentVO detail(String stNo);

	public int updateStd(Map<String, Object> map);

	public int updateStdStat(Map<String, Object> map);

	public List<ComCodeVO> getCollege();

	public List<ComDetCodeVO> getDept(Map<String, Object> map);

	public String getStNo(Map<String, Object> map);

	public List<ProfessorVO> getProfList(Map<String, Object> map);

	public int stuAdd(StudentVO studentVO);

}
