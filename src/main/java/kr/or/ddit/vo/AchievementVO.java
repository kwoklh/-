package kr.or.ddit.vo;

import lombok.Data;

/**
 * @author PC-11
 * 성적 VO
 */
@Data
public class AchievementVO {
	private String stuLecNo;		// 수강 번호
	private int achieveScore;		// 최종 점수
	private String achieveGrade;	// 성적 등급
	private String lecYn;			// 이의 신청 여부
}
