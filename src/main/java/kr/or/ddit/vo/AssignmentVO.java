package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 과제 VO
 */
@Data
public class AssignmentVO {
	private String assigNo;			// 과제 번호
	private String lecNo;			// 강의 번호
	private Date assigDeadline;		// 과제 제출 기한
	private String assigName;		// 과제 제목
	private String assigCon;		// 과제 내용
	private Date assigRegDate;		// 과제 등록 날짜
}
