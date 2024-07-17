package kr.or.ddit.vo;

import java.sql.Date;

import lombok.Data;

/**
 * @author PC-11
 * 강의 상세 VO
 */
@Data
public class LectureDetailVO {
	private int lecNum;				// 강의 회차
	private Date lecDate;			// 강의 날짜
	private String lecNo;			// 강의번호
	private String lecCon;			// 강의 주요 내용
}
