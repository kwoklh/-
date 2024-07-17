package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 *
 */
@Data
public class DepartmentCostVO {
	private String deptCode;			// 학과 코드
	private String deptCostType;		// 유지비 종류
	private int deptCostPayment;		// 지급액
	private Date deptCostPaymentDate;	// 유지비 지급 날짜
	private int deptBalance;			// 잔액
	private String userNo;				// 지급관리자
}
