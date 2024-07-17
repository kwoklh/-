package kr.or.ddit.vo;

import lombok.Data;

/**
 * @author PC-11
 * 강의추천받은내역VO
 */
@Data
public class TimeLectureRecomVO {
	private String timeNo;          // 일련번호
	private String stNo;            // 학번
	private String stuLecNo;		// 수강번호
}
