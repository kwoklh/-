package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.LectureVO;

public interface ProfTimeTableService {

	List<LectureVO> profLecList(String userNo);

}
