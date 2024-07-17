package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 타임 댓글 VO
 */
@Data
public class TimeCommentVO {
	private String timeBono;			// 댓글번호
	private Date timeDate;              // 게시글번호
	private String timeCon;			    // 작성일자
	private String timeCono;			// 댓글내용
	private String stNo;                // 댓글작성자
	private String timeCommDelYn;       // 타임댓글삭제여부
}
