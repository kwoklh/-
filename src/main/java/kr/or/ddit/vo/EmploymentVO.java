package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 취업 현황 VO
 */
@Data
public class EmploymentVO {
	private String empNo;			// 취업 번호
	private String stNo;			// 학번
	private String empCompany;		// 회사 이름
	private String empComGubun;		// 회사 구분
	private Date empComDate;		// 입사 날짜
}
