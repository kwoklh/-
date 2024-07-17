package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.StuLectureMapper;
import kr.or.ddit.service.StuLectureService;
import kr.or.ddit.vo.StuLectureVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.TimeExchangeManageVO;

/**
 * @author PC-10
 * 내 강의
 */
@Service
public class StuLectureServiceImpl implements StuLectureService {

	@Autowired
	StuLectureMapper stuLectureMapper; 
	
	//내 강의 목록
	@Override
	public List<StuLectureVO> myLecture(String stNo) {
		return this.stuLectureMapper.myLecture(stNo);
	}

	//내 학년, 학기
	@Override
	public StudentVO studentVO(String stNo) {
		return this.stuLectureMapper.studentVO(stNo);
	}

	//수강 중인 강의 상세 정보 출력
	@Override
	public List<StuLectureVO> myLectureDetail(String stNo) {
		return this.stuLectureMapper.myLectureDetail(stNo);
	}

	//학생 정보 데이터 찾기
	@Override
	public StudentVO stNoFindAjax(String stNoFind) {
		return this.stuLectureMapper.stNoFindAjax(stNoFind);
	}

	// 강의 거래 내역에 추가
	@Override
	public int timeExchangeManageInsert(Map<String, Object> map) {
		return this.stuLectureMapper.timeExchangeManageInsert(map);
	}
	
	// 강의 거래 내역 목록
	@Override
	public List<TimeExchangeManageVO> exchangeHistory(Map<String,Object> map) {
		return this.stuLectureMapper.exchangeHistory(map);
	}

	// 전체 행수
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.stuLectureMapper.getTotal(map);
	}

	// 강의 거래 내역 update
	@Override 
	public int excHisOkAjaxUpdate(TimeExchangeManageVO timeExchangeManageVO) {
		return this.stuLectureMapper.excHisOkAjaxUpdate(timeExchangeManageVO);
	}

	// 강의 거래 완료 내 수강 내역 수정
	@Override
	public int lectureExchangeUpdate(TimeExchangeManageVO timeExchangeManageVO) {
		return this.stuLectureMapper.lectureExchangeUpdate(timeExchangeManageVO);
	}

	// 거래한 강의 정보 출력
	@Override
	public StuLectureVO excHisDetail(String timeExNo) {
		return this.stuLectureMapper.excHisDetail(timeExNo);
	}

	// 보낸 사람 학번 가져옴
	@Override
	public String timeSendIdComparison(String timeExNo) {
		return this.stuLectureMapper.timeSendIdComparison(timeExNo);
	}

	// 받는 사람 학번 가져옴
	@Override
	public String timeTakeIdComparison(String timeExNo) {
		return this.stuLectureMapper.timeTakeIdComparison(timeExNo);
	}

	// 거래한 사람 정보 출력
	@Override
	public StudentVO timeStudent(String searchStNo) {
		return this.stuLectureMapper.timeStudent(searchStNo);
	}

}
