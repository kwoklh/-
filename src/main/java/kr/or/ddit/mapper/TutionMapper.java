package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.ScolarshipHistoryVO;
import kr.or.ddit.vo.StudentVO;

public interface TutionMapper {

	// 한 학생의 장학금 수혜 내역
	List<ScolarshipHistoryVO> list(String stNo);

	// 학생의 학과별 등록금
	StudentVO depttui(String stNo);

	// 조건별 장학금 수혜 내역
	List<ScolarshipHistoryVO> conlist(ScolarshipHistoryVO scolarshipHistoryVO);

}
