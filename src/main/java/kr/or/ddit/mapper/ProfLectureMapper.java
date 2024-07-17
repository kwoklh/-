package kr.or.ddit.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.BuildingInfoVO;
import kr.or.ddit.vo.ComCodeVO;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.LecTimeVO;
import kr.or.ddit.vo.LectureDetailVO;
import kr.or.ddit.vo.LectureRoomVO;
import kr.or.ddit.vo.LectureVO;

public interface ProfLectureMapper {            
	// 단과대 리스트
	List<ComCodeVO> collegeList();
	
	// 학과 리스트
	List<ComDetCodeVO> deptList(String collegeCode);
	
	// 건물 리스트 
	List<BuildingInfoVO> buildList();
	
	// 건물 검색 리스트
	List<BuildingInfoVO> buildSearchList(String buildSeaWord);
	
	// 강의실 리스트
	List<LectureRoomVO> buildChoice(Map<String, Object> param);
	
	// 강의 등록
	int lecCreate(LectureVO lectureVO);
	
	// 첨부파일 컬럼 값 넣으려고 가져오는..
	String comAttMId();
	
	// 강의 시간 등록
	int lecTimeCreate(LecTimeVO lecTimeVO);
	
	// 강의 디테일 등록
	int lecDetCreate(LectureDetailVO lecturDetailVO);
	
	// 강의 등록 리스트
	List<LectureVO> lectureList(String proNo);
	
	// 현재 강의 목록 (성적 등록을 위한 목록 출력)
	List<LectureVO> achiLectureList(String proNo);
}
