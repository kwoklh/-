package kr.or.ddit.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.BuildingInfoVO;
import kr.or.ddit.vo.ComCodeVO;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.LectureRoomVO;
import kr.or.ddit.vo.LectureVO;

public interface ProfLectureService {

	List<ComCodeVO> collegeList();

	List<ComDetCodeVO> deptList(String collegeCode);
	
	// 건물목록
	List<BuildingInfoVO> buildList();
	
	// 건물 검색 목록
	List<BuildingInfoVO> buildSearchList(String buildSeaWord);
	
	// 강의실목록
	List<LectureRoomVO> buildChoice(Map<String, Object> param);
	
	// 강의 등록
	int lecCreate(LectureVO lectureVO);
	
	// 강의 등록 목록 (다음 학기 강의)
	List<LectureVO> lectureList(String proNo);
	
	// 현재 학기 강의 목록(성적등록에 출력)
	List<LectureVO> achiLectureList(String proNo);

}
