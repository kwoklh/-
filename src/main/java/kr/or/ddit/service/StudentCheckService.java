package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.StudentVO;

public interface StudentCheckService {
	
	//목록 뷰 
	public List<StudentVO>list(Map<String,Object>map); 
	//상세 뷰 
	public StudentVO stdDetail(StudentVO studentVO);
	
	public List<StudentVO> searchList(Map<String, Object> map);
}
