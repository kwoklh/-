package kr.or.ddit.vo;

import lombok.Data;

/**
 * @author PC-11
 * 학과 관리 VO
 */
@Data
public class DeptVO {
	private String deptCode;		// 공통 상세 코드
	private String deptTel;			// 연락처
	private String deptLocal;		// 학과 위치
}
