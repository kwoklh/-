package kr.or.ddit.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.ProfLectureMapper;
import kr.or.ddit.service.ProfLectureService;
import kr.or.ddit.util.UploadUtils;
import kr.or.ddit.vo.BuildingInfoVO;
import kr.or.ddit.vo.ComCodeVO;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.LecTimeVO;
import kr.or.ddit.vo.LectureDetailVO;
import kr.or.ddit.vo.LectureRoomVO;
import kr.or.ddit.vo.LectureVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProfLectureServiceImpl implements ProfLectureService {
	
	@Autowired
	ProfLectureMapper profLecturetMapper; 
	
	@Autowired
	UploadUtils uploadUtils;
	
	// 단과대 리스트 출력
	@Override
	public List<ComCodeVO> collegeList() {
		return profLecturetMapper.collegeList();
	}
	
	// 선택한 단과대에 속하는 학과 리스트 출력
	@Override
	public List<ComDetCodeVO> deptList(String collegeCode) {
		return profLecturetMapper.deptList(collegeCode);
	}

	@Override
	public List<BuildingInfoVO> buildList() {
		return profLecturetMapper.buildList();
	}
	
	@Override
	public List<BuildingInfoVO> buildSearchList(String buildSeaWord) {
		return profLecturetMapper.buildSearchList(buildSeaWord);
	}
	
	// 강의실 목록 출력
	@Override
	public List<LectureRoomVO> buildChoice(Map<String, Object> param) {
		return profLecturetMapper.buildChoice(param);
	}
	
	//강의 등록
	@Override
	@Transactional
	public int lecCreate(LectureVO lectureVO) {
		
		// COM_ATT_M_ID 생성할 테이블 번호 가져오기
		String lecNo = profLecturetMapper.comAttMId();
		String proNo = lectureVO.getProNo();
		String comAttMId = proNo+"lecture"+lecNo;
		log.info("comAttMId >>>>>>> {}", comAttMId);
		
		// COM_ATTACH_FILE 테이블에 추가 + 파일 업로드
		MultipartFile lecFile = lectureVO.getLecFile();
		int result = uploadUtils.uploadOne(lecFile, comAttMId);
		log.info("lecCreate>>uploadController : {}", result);
		
		// lecture 테이블에 insert
		lectureVO.setFileName(comAttMId);
		result += profLecturetMapper.lecCreate(lectureVO);
		log.info("lecCreate>>lecture insert : {}", result);
		
		// lecture_time 테이블에 insert
		List<LecTimeVO> lecTimeVOList = lectureVO.getLecTimeVOList();
		for(LecTimeVO lecTimeVO : lecTimeVOList) {
			result += profLecturetMapper.lecTimeCreate(lecTimeVO);
		}
		log.info("lecCreate>>lecture_time insert : {}", result);
		
		// lecture_detail 테이블에 insert
		List<LectureDetailVO> lectuerDetailVOList = lectureVO.getLectureDetailVOList();
		for(LectureDetailVO lecturDetailVO : lectuerDetailVOList) {
			lecturDetailVO.setLecNo(lecNo);
			result += profLecturetMapper.lecDetCreate(lecturDetailVO);
		}
		log.info("lecCreate>>lecture_detail insert : {}", result);
		
		return result;
	}
	
	// 강의 등록 목록
	@Override
	public List<LectureVO> lectureList(String proNo) {
		return profLecturetMapper.lectureList(proNo);
	}
	
	// 성적등록용 강의 목록(현재 학기 강의 목록)
	@Override
	public List<LectureVO> achiLectureList(String proNo) {
		return profLecturetMapper.achiLectureList(proNo);
	}
	
}
