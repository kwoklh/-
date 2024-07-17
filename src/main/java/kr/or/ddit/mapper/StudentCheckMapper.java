package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.StudentVO;

public interface StudentCheckMapper {

	public List<StudentVO> list(Map<String, Object>map);

	public StudentVO stdDetail(StudentVO studentVO);

	public List<StudentVO> searchList(Map<String, Object> map);

}
