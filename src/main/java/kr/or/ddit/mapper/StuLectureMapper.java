package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.StuLectureVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.TimeExchangeManageVO;

/**
 * @author PC-10
 * 내 강의
 */
public interface StuLectureMapper {
	//내 강의 목록
	public List<StuLectureVO> myLecture(String stNo);

	//내 학년, 학기
	public StudentVO studentVO(String stNo);

	//수강 중인 강의 상세 정보 출력
	public List<StuLectureVO> myLectureDetail(String stNo);

	//학생 정보 데이터 찾기
	public StudentVO stNoFindAjax(String stNoFind);

	//강의 거래 내역에 추가
	public int timeExchangeManageInsert(Map<String, Object> map);

	//강의 거래 내역 목록
	public List<TimeExchangeManageVO> exchangeHistory(Map<String,Object> map);

	//전체 행수
	public int getTotal(Map<String, Object> map);

	//강의 거래 내역 update
	public int excHisOkAjaxUpdate(TimeExchangeManageVO timeExchangeManageVO);

	//강의 거래 완료 내 수강 내역 수정
	public int lectureExchangeUpdate(TimeExchangeManageVO timeExchangeManageVO);
	
	//거래한 강의 정보 출력
	public StuLectureVO excHisDetail(String timeExNo);
	
	//보낸 사람 학번 가져옴
	public String timeSendIdComparison(String timeExNo);

	//받는 사람 학번 가져옴
	public String timeTakeIdComparison(String timeExNo);

	//거래한 사람 정보 출력
	public StudentVO timeStudent(String searchStNo);
}
