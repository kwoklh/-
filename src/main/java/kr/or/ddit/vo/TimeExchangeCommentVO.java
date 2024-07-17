package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 타임 강의 거래 댓글 VO
 */
@Data
public class TimeExchangeCommentVO {
	private String timeExCommNo;		// 댓글번호
	private String timeExNo;            // 거래게시글번호
	private String stNo;                // 작성자번호
	private Date timeExCommDate;        // 거래댓글작성일자
	private String timeExCommCon;       // 거래댓글내용
	private String timeExCommDelYn;     // 거래댓글삭제여부
}
