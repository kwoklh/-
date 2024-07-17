package kr.or.ddit.vo;

import lombok.Data;

/**
 * @author PC-11
 * 타임 신고 내역 VO
 */
@Data
public class TimeDeclareVO {
	private String timeDeno;            // 신고 번호
	private String timeDereason;        // 신고 사유
	private String timeBDiv;            // 게시글 구분 코드
	private String timeDeBNo;           // 신고글 번호
	private String timeDeUrl;           // 신고글 URL
	private String timeDeId;			// 신고자 ID
}
