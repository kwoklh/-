package kr.or.ddit.vo;

import lombok.Data;

/**
 * @author PC-11
 * 상남 내역 VO
 */
@Data
public class ConsultingRecordVO {
	private String conNo;		// 상담 번호
	private String conReqNo;	// 상담 신청 번호
	private String proNo;		// 교수 번호
	private String conCont;		// 상담 내역
}
