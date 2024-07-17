package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

/**
 * @author PC-11
 * 전체 수강 내역 VO
 */
@Data
public class StuLectureVO {
	private String stuLecNo;		// 수강 번호
	private String lecNo;			// 강의 번호
	private String stuLecReYn;		// 재수강 여부
	private String stuLecDelYn;		// 수강 철회 여부
	private String stuLecDiv;		// 이수 구분
	private String stNo;			// 학번
	private String stuLecSitu;		// 수강 상태
	private int stuEvalTt;			// 강의 평가 총 점
	private String stuLecDay; //학번과 강의코드를 조건으로 요일, 강의시작시간~강의종료시간을 문자열로 리턴
	
	private int stuLecCount; //강의인원
	private String suNum; //중복 허용을 위한 아이디 구분용 (내 수강 리스트)
	private LectureVO lectureVOList; // 강의 내역
	private List<LecTimeVO> lecTimeVOList; // 강의시간 (수강신청 강의시간표 뽑을때 필요)
	private TimeExchangeManageVO timeExchangeManageVOList; //강의거래 내역
	private StuLectureVO stuLectureVO;
	private UserInfoVO userInfoVO; //
	private StudentVO studentVO;	//학생 테이블
	private ComDetCodeVO comDetCodeVO; // 공통상세테이블
	private LectureDetailVO lectureDetailVO; // 수업상세테이블
}
