package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 문의 답변 관리 VO
 */
@Data
public class AnswerVO {
	private String ansNo;			// 답변 번호
	private String queNo;			// 문의글 번호
	private String ansContent;		// 답변 내용
	private Date ansFDate;			// 답변최종작성일자
	private String ansFUserId;		// 답변최종작성자ID
}
