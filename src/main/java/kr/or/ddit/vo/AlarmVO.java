package kr.or.ddit.vo;

import lombok.Data;

/**
 * @author PC-11
 * 알람 메세지 VO
 */
@Data
public class AlarmVO {
	private int alaNo;		// 알람메세지 일련번호
	private String alaCat;	// 카테고리
	private String alaTit;	// 알람 제목
	private String alaCon;	// 알람 내용
	private String alaUrl;	// 이동 URL
}
