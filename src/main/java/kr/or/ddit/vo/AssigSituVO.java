package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * @author PC-11
 * 과제제출관리 VO
 */
@Data
public class AssigSituVO {
	private String stuLecNo;		// 수강 번호
	private String assigNo;			// 과제 번호
	private String lecNo;			// 강의 번호
	private Date assigDate;			// 과제 제출 날짜
	private String assigWhether;	// 과제 제출 여부
	private int assigScore;			// 과제 점수
	private MultipartFile attFile;	// 첨부 파일
}
