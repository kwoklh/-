package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 졸업 자료 제출 게시판 댓글 VO
 */
@Data
public class StuSubBoardCommVO {
	private int stuSubCommNo;			// 자료 제출 댓글 번호
	private int stuSubmitNo;			// 게시글 번호
	private String stNo;				// 학번
	private String proNo;				// 교수 번호
	private String stuSubCommCon;		// 자료 제출 댓글 내용
	private Date stuSubCommDate;		// 자료 제출 댓글 작성 일자
}
