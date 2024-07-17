package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 등록금 VO
 */
@Data
public class TuitionVO {
	private String semester;			// 학번 
	private int year;                   // 학기 
	private String stNo;                // 년도 
	private int tuiCost;                // 등록금금액 
	private Date tuiSchedule;           // 등록금납부기한 
	private String tuiPayYn;            // 등록금완납여부 
}
