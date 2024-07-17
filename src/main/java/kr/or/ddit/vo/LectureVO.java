package kr.or.ddit.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * @author PC-11
 * 강의 VO
 */
@Data
public class LectureVO {
	private int rownum;
	private String lecNo;			// 강의 번호
	private String proNo;			// 교수 번호
	private int lecYear;			// 강의 연도
	private String 	lecSemester;	// 강의 학기
	private int lecPer;				// 수강 최대 인원
	private String lecName;			// 강의명
	private String lecType;			// 강의 영역
	private int lecScore;			// 학점
	private MultipartFile lecFile;	// 강의계획서			
	private String deptCode;		// 학과 코드
	private String lecDiv;			// 이수 구분
	private String lecCol;			// 강의 구분 색상 
	private String lecRoNo;			//강의실번호
	private String fileName;		// 파일 저장 이름
	private String lecDay;
	private int stuCount;			// 강의 현재 인원
	private int lecGrade;			// 강의 학년
	
	private List<LectureDetailVO> lectureDetailVOList; // 강의 상세 VO
	private UserInfoVO userInfoVO;
	private ComDetCodeVO comDetCodeVO;
	private LectureRoomVO lectureRoomVO; // 강의실 정보
	private LecTimeVO lecTimeVO; // 강의 시간
	private List<LecTimeVO> lecTimeVOList; //강의 시간(강의 등록 시 사용)
//	private List<LectureRoomVO> lectureRoomVOList; // 강의실 정보
	private List<StuLectureVO> stuLectureVOList;// 전체수강내역
}
