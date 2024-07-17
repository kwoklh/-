package kr.or.ddit.vo;

import lombok.Data;

/**
 * @author PC-11
 * 등록금 관리 VO
 */
@Data 
public class DeptTuitionPayVO {
	private String deptCode;	// 공통 코드
	private int year;			// 년도
	private int deptTuiPay;		// 등록금액
}	
