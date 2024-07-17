package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 등록금납부내역
 */
@Data
public class TuitionPayVO {
	private String semester;				// 학기
	private String stNo;                    // 학번
	private int year;                       // 년도
	private Date tuiPayDate;                // 등록금납부날짜
	private int tuiPayAmount;               // 등록금납부금액
	private int tuiPayReAmount;             // 등록금잔여금액
	private String scolDNo;                 // 장학금상세번호
	private String tuiPayInstallYn;         // 등록금납부성격
}
