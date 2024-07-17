package kr.or.ddit.vo;

import lombok.Data;

/**
 * @author PC-11
 * 공통 상세 코드 VO
 */
@Data
public class ComDetCodeVO {
	private String comDetCode;			// 공통 상세 코드
	private String comDetCodeName;		// 상세 코드 명
	private String comDetUseYn;			// 사용 여부
	private String comCode;				// 분류 코드
}
