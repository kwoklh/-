package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 학과 유지비 사용 기록 VO
 */
@Data
public class DepartReportVO {
	private String deptNo;			// 사용 번호
	private String deptCode;		// 학과 코드
	private String deptCostType;	// 유지비 종류
	private Date deptDate;			// 사용 날짜
	private String deptPay;			// 사용 금액
}
