package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * @author PC-11
 * 학과 공지사항 VO
 */
@Data
public class DeptNoticeVO {
	private String deptNotNo;				// 학과 공지번호
	private String proNo;					// 교수번호
	private String deptNotName;				// 학과 공지제목
	private String deptNotCon;				// 학과 공지내용
	private int deptNotViews;				// 학과 공지 조회수
	private Date deptFirstDate;				// 최초 작성일
	private String deptFirstWriter;			// 최초 작성자
	private Date deptEndDate;				// 최종 작성일
	private String deptEndWriter;			// 최종 작성자
	private String deptNotDelYn;			// 학과 공지 삭제 여부
	private MultipartFile deptNotAttFile;	// 학과 공지 첨부파일
}
