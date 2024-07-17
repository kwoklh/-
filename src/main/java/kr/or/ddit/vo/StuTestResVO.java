package kr.or.ddit.vo;

import lombok.Data;

/**
 * @author PC-11
 * 시험 결과 VO
 */
@Data
public class StuTestResVO {
	private String stuLecNo;		// 수강 번호
	private String stuTestDiv;		// 중간 기말 구분
	private String lecNo2;			// 강의 번호
	private int stuTestScore;		// 시험 점수
}
