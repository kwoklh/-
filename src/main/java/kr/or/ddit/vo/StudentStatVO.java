package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * @author PC-11
 * 학생 상태 이력 VO
 */
@Data
public class StudentStatVO {
	private String stStat;					// 학생 상태
	private String stNo;					// 학번
	private Date stDate;					// 접수 일자
	private String stSitu;					// 승인 상태
	private Date stSituDate;				// 승인 상태 변경 일자
	private Date stSituEndDate;				// 종료 예정 일자
	private MultipartFile comAttDetNo;		// 첨부파일
	private Date stSituStDate;				// 상태 시작 일자
	private String stSituAppCon;			// 상태 신청 사유
	private Date stSituAppFUpdDate;			// 상태 신청 최종 수정 일자
}
