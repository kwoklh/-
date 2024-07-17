package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 알람 수신자 정보 VO
 */
@Data
public class AlaRecepientVO {
	private String alaId;	// 수신자 ID
	private int alaNo;		// 알림메세지 일련번호
	private String alaYn;	// 수신 여부
	private Date alaTime;	// 수신 시간
}
