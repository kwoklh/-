package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 강의 거래 내역 관리 VO
 */
@Data
public class TimeExchangeManageVO {
	private String rn;				// 화면에 보여주는 용 번호
	private String timeExNo;		// 거래번호
	private String lecType;         // 거래종류
	private String timeTakeId;      // 받은사람 아이디
	private String timeSendId;      // 보낸사람 아이디
	private String exReqDate;		// 거래신청일시 (날짜)
	private String exReqDateTime;	// 거래신청일시 (시간)
	private String exAppYn;         // 거래승인여부
	private String exAppDate;		// 거래승인일시 (날짜)
	private String exAppDateTime;	// 거래승인일시 (시간)
	private String stuLecNo;        // 수강번호
}
