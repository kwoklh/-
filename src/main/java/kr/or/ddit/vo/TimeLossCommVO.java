package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 타임분실물게시판댓글 VO
 */
@Data
public class TimeLossCommVO {
	private String timeLoCommNo;		// 분실댓글번호
	private Date timeLoCommDate;        // 분실댓글작성일자
	private String timeLoCommCon;       // 분실댓글내용
	private String timeLoNo;            // 분실게시글번호
	private String timeDelYn;           // 분실댓글삭제여부
}
