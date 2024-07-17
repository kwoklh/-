package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * @author PC-11
 * 학생 관리 VO
 */
@Data
public class StudentVO {
	private String stNo;				// 학번
	private String stName;				// 이름 (신입생 추가 시 jsp에서 받아오는 용도)
	private String stTel;				// 연락처 (신입생 추가 시 jsp에서 받아오는 용도)
	private String stGender;			// 성별
	private int stPostno;				// 학생 우편 번호
	private String stAddr;				// 학생 주소
	private String 	stAddrDet;			// 학생 상세 주소
	private String stAcount;			// 계좌 번호
	private String 	stBank;				// 계좌 은행
	private String 	militaryService;	// 병역 사항
	private String 	stEmail;			// 이메일
	private String 	proChaNo;			// 담당 교수 번호
	private String admissionDate;			// 입학 일자
	private String stGradDate;			// 졸업 일자
	private String 	deptCode;			// 학과 코드
	private int stGrade;// 학년
	private String pwd; // 임시비밀번호 (비밀번호 찾기 사용)
	private int stSemester;				// 학기
	private MultipartFile uploadFile;
	
	private UserInfoVO userInfoVO;		// 유저 정보
	private ComDetCodeVO comDetCodeVO;	// 공통상세코드(학과)
	private StuAttachFileVO stuAttachFileVO; // 학생 첨부파일
	private ComCodeVO comCodeVO; // 공통코드(단과대학)
	private StudentStatVO studentStatVO; // 학생상태
	private DeptTuitionPayVO deptTuitionPayVO; // 학과 등록금
	
}
