package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 강의자랑댓글 VO
 */
@Data
public class TimeBoastCommVO {
	private String timeBoaCommNo;		// 강의자랑댓글번호
	private String stNo;				// 작성자 아이디
	private String timeLecBoNo;			// 강의자랑게시글번호
	private Date timeBoaCommDate;		// 강의자랑댓글작성일자
	private String timeBoaCommCon;		// 강의자랑댓글내용
	private String timeBoaCommYn;		// 강의자랑댓글삭제여부
}
