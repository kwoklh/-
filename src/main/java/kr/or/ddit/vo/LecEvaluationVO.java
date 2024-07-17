package kr.or.ddit.vo;

import lombok.Data;

/**
 * @author PC-11
 * 강의 평가 VO
 */
@Data
public class LecEvaluationVO {
	private String stuLecNo;		// 수강 번호
	private String lecEvalItemNo;	// 항목 번호
	private int lecEvalScore;		// 점수
	private String lecEvalOp;		// 기타 의견
}
