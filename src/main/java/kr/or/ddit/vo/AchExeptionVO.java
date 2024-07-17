package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 성적이의신청관리 VO
 */
@Data
public class AchExeptionVO {
	private String stuLecNo;			// 수강 번호
	private String achExeptionCon;		// 이의 신청 내용
	private String achExeptionBefore;	// 이의 신청 전 성적
	private String achExeptionAfter;	// 이의 신청 후 성적
	private Date achExeptionDate;		// 이의 신청 날짜
	private String achExepStat;			// 이의 신청 승인 상태
    private Date achExepAppDate;		// 이의 신청 승인 날짜
}
