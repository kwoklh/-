package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 알람 발송자 정보 VO
 */
@Data
public class AlaSenderVO {
	private int alaNo;		// 알람메세지 일련번호
	private Date alaTime;	// 발송 시간
}
