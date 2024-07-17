package kr.or.ddit.vo;

import lombok.Data;

/**
 * @author PC-11
 * 
 */
@Data
public class GraduateRequirementVO {
	private int gradNo;			// 일련 번호
	private String gradReq;		// 졸업 요구 사항
	private int gradVolunter;	// 졸업 요구 사항 필요 수치
}
