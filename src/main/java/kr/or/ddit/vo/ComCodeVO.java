package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

/**
 * @author PC-11
 * 공통 분류 코드 VO
 */
@Data
public class ComCodeVO {
	private String comCode;			// 분류 코드
	private String comCodeName;		// 분류 코드 명
	private String comCodeContent;	// 분류 코드 설명
	private String comCodeUseYn;	// 사용 여부
	
	// 공통 상세 코드 리스트
	private List<ComDetCodeVO> comDetCodeVOList;
}
