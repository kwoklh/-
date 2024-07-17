package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 교내 근로자 VO
 */
@Data
public class SchoolEmployeeVO {
	private String schEmNo;
	private String schEmName;
	private String schEmStart;
	private String schEmEnd;
	private int schEmSalary;
	private String schEmDept;
	
	private ComCodeVO comCodeVO;
	private ComDetCodeVO comDetCodeVO;
}
